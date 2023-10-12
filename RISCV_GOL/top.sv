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
	//logic [7:0] ; 
	
	// CPU
	RISCV CPU_RISCV(sysclk, SW[0], pc, instruction, mem_write, alu_result, write_data, read_data);
	
	always @(posedge sysclk)
		if(SW[0])
			LEDR[0] <= 0;
		else if(pc == 32'h78 && instruction == 32'h2112623)
			LEDR[0] <= 1;
	
	//assign LEDR[4] = (pc[0] == 32'd4);
	// Memoria 
   imem imem(pc, instruction);
   //dmem dmem((SW[0]) ? 32'b0 : addr_vga, read_data_vga);
	dmem dmem(sysclk,mem_write, alu_result, (SW[0]) ? 32'b0 : addr_vga, write_data, read_data, read_data_vga);
	//mem memVGA(VGA_CLK, adr_vga, read_data_vga);
  
   // wire VGA_DA; // In display area
	// wire VGA_PIXEL;
	// logic [31:0] mem_pos; 
	 
	//initial 
	//	mem_pos = 0;
	 
	pll	clk_wiz_1_inst (sysclk, VGA_CLK);
	vga video(VGA_CLK, SW, read_data_vga[7:0], VGA_R, VGA_G, VGA_B, VGA_HS_O, VGA_VS_O, addr_vga);
	
  assign VGA_BLANK_N = 1'b1;
  assign VGA_SYNC_N  = 1'b0;
endmodule

