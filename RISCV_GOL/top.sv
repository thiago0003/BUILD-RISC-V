// Instancia devidamente os modulos
module top #(parameter VGA_BITS = 8) (
			  input sysclk, 
			  input [3:0] SW,
			  output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
			  output VGA_HS_O, VGA_VS_O,
			  output reg VGA_CLK, VGA_BLANK_N, VGA_SYNC_N);

	//logic [31:0] pc, instruction, read_data;
	//logic [7:0] adr_vga, read_data_vga;
	
	
	// CPU
	//CPU_RISCV CPU_RISCV(KEY[0], SW[0], pc, instruction, mem_write, alu_result, write_data, read_data);
	
	//assign LEDR[4] = (pc[0] == 32'd4);
	// Memoria 
   //imem imem(pc, instruction);
   //dmem dmem(KEY[0], mem_write, alu_result, (KEY[0]) ? 0 :adr_vga, write_data, read_data, read_data_vga);
	//mem memVGA(VGA_CLK, adr_vga, read_data_vga);
  
   // wire VGA_DA; // In display area
	// wire VGA_PIXEL;
	// logic [31:0] mem_pos; 
	 
	//initial 
	//	mem_pos = 0;
	 
	pll	clk_wiz_1_inst (sysclk, VGA_CLK);
	vga video(VGA_CLK, SW, VGA_R, VGA_G, VGA_B, VGA_HS_O, VGA_VS_O);
	
  assign VGA_BLANK_N = 1'b1;
  assign VGA_SYNC_N  = 1'b0;
endmodule


module vga #(parameter VGA_BITS = 8) (
  input clk,
  input [3:0] SW,
  output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
  output VGA_HS_O, VGA_VS_O);

  reg [9:0] CounterX, CounterY;
  reg inDisplayArea;
  reg vga_HS, vga_VS;
  wire [3:0] row, col;
  wire [7:0] vdata;
  wire [8:0] vaddr;

  wire CounterXmaxed = (CounterX == 800); // 16 + 48 + 96 + 640
  wire CounterYmaxed = (CounterY == 525); // 10 +  2 + 33 + 480

  always @(posedge clk)
	 if(SW[0])
		CounterX <= 10'b0;
    else if (CounterXmaxed)
      CounterX <= 10'b0;
    else
      CounterX <= CounterX + 1'b1;
		
	always @(posedge clk)	
		if(SW[0])
			CounterY <= 10'b0;
		else if (CounterXmaxed)
			if(CounterYmaxed)
				CounterY <= 10'b0;
		else
			CounterY <= CounterY + 1'b1;
    
		  
  assign row = (CounterY>>5);
  assign col = (CounterX>>5);
  assign vaddr = 212 + col + (row<<4) + (row<<2);

  always @(posedge clk)
  begin
    vga_HS <= (CounterX > (640 + 16) && (CounterX < (640 + 16 + 96)));   // active for 96 clocks
    vga_VS <= (CounterY > (480 + 10) && (CounterY < (480 + 10 +  2)));   // active for  2 clocks
    inDisplayArea <= (CounterX < 640) && (CounterY < 480);	
  end

  assign VGA_HS_O = ~vga_HS;
  assign VGA_VS_O = ~vga_VS;

  assign VGA_R = inDisplayArea ? {8{SW[3]}} ^ {vdata[5:4], 6'b000000} : 8'b00000000;
  assign VGA_G = inDisplayArea ? {8{SW[2]}} ^ {vdata[3:2], 6'b000000} : 8'b00000000;
  assign VGA_B = inDisplayArea ? {8{SW[1]}} ^ {vdata[1:0], 6'b000000} : 8'b00000000;
  
  mem video(vaddr, vdata);
endmodule
