// Instancia devidamente os modulos
module top #(parameter VGA_BITS = 8) (
			  input CLOCK_50, // 50MHz
			  input [3:0] SW,
			  output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
			  output VGA_HS_O, VGA_VS_O,
			  output reg VGA_CLK, 
			  output VGA_BLANK_N, VGA_SYNC_N);

	logic [31:0] pc, instruction, read_data, adr_vga, read_data_vga;
	// CPU
	CPU_RISCV CPU_RISCV(CLOCK_50, SW[0], pc, instruction, mem_write, alu_result, write_data, read_data);
	
	// Memoria 
  imem imem(pc, instruction);
  dmem dmem(CLOCK_50, mem_write, alu_result, adr_vga, write_data, read_data, read_data_vga);

  
    wire VGA_DA; // In display area
	 wire VGA_PIXEL;
	 logic [31:0] mem_pos; 
	 
	initial 
		mem_pos = 0;
	 
	 always@(posedge CLOCK_50) begin
		VGA_CLK = ~VGA_CLK; // 25MHz
		mem_pos = (mem_pos > 32'h2580) ? 32'b0 : mem_pos + 4;
	 end
		
	  logic [63:0] fifo_vga;
	  //fifo with VGA feed
	  always@(posedge VGA_CLK) begin
		  fifo_vga[63:32]<=read_data[31:0]; //continuous feed (double size)
		  fifo_vga<=fifo_vga>>1; 
		  VGA_PIXEL <= fifo_vga[0];
	  end
	  vga video(VGA_CLK, VGA_HS_O, VGA_VS_O, VGA_DA);
	  
	  assign VGA_R = {VGA_BITS{VGA_DA ? SW[3] ^ VGA_PIXEL : 1'b0}};
	  assign VGA_G = {VGA_BITS{VGA_DA ? SW[2] ^ VGA_PIXEL : 1'b0}};
	  assign VGA_B = {VGA_BITS{VGA_DA ? SW[1] ^ VGA_PIXEL : 1'b0}};
	  assign VGA_BLANK_N = 1'b1;
	  assign VGA_SYNC_N  = 1'b0;
endmodule 