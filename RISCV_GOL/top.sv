// Instancia devidamente os modulos
module top #(parameter VGA_BITS = 8) (
			  input sysclk, 
			  input [3:0] SW,
			  output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
			  output VGA_HS_O, VGA_VS_O,
			  output reg VGA_CLK, VGA_BLANK_N, VGA_SYNC_N);

	wire [31:0] pc, instruction, read_data, alu_result, read_data_vga, write_data;
	wire [ 8:0] addr_vga; // 2**7 = 128 > 75 (words) = 300 (bytes) = 20*15 (res) = 32x32 pixel;
	wire mem_write;
	
	// CPU
	RISCV CPU_RISCV(VGA_CLK, SW[0], pc, instruction, mem_write, alu_result, write_data, read_data);
			
	// Memoria 
   imem imem(pc, instruction);
	dmem dmem(VGA_CLK, mem_write, alu_result, addr_vga, write_data, read_data, read_data_vga);
	 				
	//pll	clk_wiz_1_inst (sysclk, VGA_CLK);
	always@(posedge sysclk)
		VGA_CLK = ~VGA_CLK; // 25MHz
	
	vga video(VGA_CLK, read_data_vga, VGA_R, VGA_G, VGA_B, VGA_HS_O, VGA_VS_O, addr_vga);
	
  assign VGA_BLANK_N = 1'b1;
  assign VGA_SYNC_N  = 1'b0;  
endmodule

