// Instancia devidamente os modulos
module top #(parameter VGA_BITS = 8) (
			  input sysclk, 
			  input [3:0] SW,
			  output [3:0]LEDR,
			  output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
			  output VGA_HS_O, VGA_VS_O,
			  output reg VGA_CLK, VGA_BLANK_N, VGA_SYNC_N);

	logic [31:0] pc, instruction, read_data, addr_vga;
	logic [31:0] read_data_vga;
	
	// CPU
	RISCV CPU_RISCV(sysclk, SW[1], pc, instruction, mem_write, alu_result, write_data, read_data);
	
	// Memoria 
   imem imem(pc, instruction);
	dmem dmem(sysclk,mem_write, alu_result, (SW[0]) ? 32'b0 : addr_vga, write_data, read_data, read_data_vga);
	 
	//pll	clk_wiz_1_inst (sysclk, VGA_CLK);
	 always@(posedge sysclk)
		VGA_CLK = ~VGA_CLK; // 25MHz
		
	vga video(VGA_CLK, SW, read_data_vga[7:0], VGA_R, VGA_G, VGA_B, VGA_HS_O, VGA_VS_O, addr_vga);
	
  assign VGA_BLANK_N = 1'b1;
  assign VGA_SYNC_N  = 1'b0;
endmodule