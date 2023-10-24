// Instancia devidamente os modulos
module top #(parameter VGA_BITS = 8) (
			  input CLOCK_50, 
			  input [3:0] SW,
			  output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
			  output VGA_HS_O, VGA_VS_O,
			  output reg VGA_CLK, VGA_BLANK_N, VGA_SYNC_N);

	wire [31:0] pc, instruction, read_data, address, read_data_vga, write_data, addr_vga;
	wire mem_write;
	wire  [3:0] byte_enable;

	//pll	clk_wiz_1_inst (CLOCK_50, VGA_CLK);
	always@(posedge CLOCK_50)
		VGA_CLK = ~VGA_CLK; // 25MHz

	// CPU
	//RISCV CPU_RISCV(CLOCK_50, SW[0], pc, instruction, mem_write, byte_enable, alu_result, write_data, read_data);
	riscvmulti cpu(CLOCK_50, SW[0], address, write_data, mem_write, read_data);
				
	// Memoria 
   //imem imem(VGA_CLK, pc, instruction);
	mem mem(address, addr_vga, byte_enable, 4'h0, write_data, 32'h00000000, mem_write, 1'b0, VGA_CLK, read_data, read_data_vga);
	vga video(VGA_CLK, read_data_vga, VGA_R, VGA_G, VGA_B, VGA_HS_O, VGA_VS_O, addr_vga);
	
  assign VGA_BLANK_N = 1'b1;
  assign VGA_SYNC_N  = 1'b0;  
endmodule

