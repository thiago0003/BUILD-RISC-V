module vga #(parameter VGA_BITS = 8) (
  input clk,
  input [31:0] vdata,
  output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
  output VGA_HS_O, VGA_VS_O,
  output [8:0] vaddr); // 2**7 = 128 > 75 (words) = 300 (bytes) = 20*15 (res) = 32x32 pixel;

  reg [9:0] CounterX, CounterY;
  reg inDisplayArea;
  reg vga_HS, vga_VS;
  wire [3:0] row;
  wire [4:0] col;
  wire [7:0] vbyte;

  wire CounterXmaxed = (CounterX == 800); // 16 + 48 + 96 + 640
  wire CounterYmaxed = (CounterY == 525); // 10 +  2 + 33 + 480

  always @(posedge clk)
  begin
    if (CounterXmaxed)
      CounterX <= 10'b0;
    else
      CounterX <= CounterX + 1'b1;
		
    if (CounterXmaxed)
      if(CounterYmaxed)
        CounterY <= 10'b0;
      else
        CounterY <= CounterY + 1'b1;
  end
 
  assign col = (CounterX>>5);
  assign row = (CounterY>>5);
  assign vaddr = col + (row<<4) + (row<<2);
  assign vbyte = col[1] ? (col[0] ? vdata[7:0] : vdata[15:8]) : (col[0] ? vdata[23:16] : vdata[31:24]); // byte select

  always @(posedge clk)
  begin
    vga_HS <= (CounterX > (640 + 16) && (CounterX < (640 + 16 + 96)));   // active for 96 clocks
    vga_VS <= (CounterY > (480 + 10) && (CounterY < (480 + 10 +  2)));   // active for  2 clocks
    inDisplayArea <= (CounterX < 640) && (CounterY < 480);	
  end

  assign VGA_HS_O = ~vga_HS;
  assign VGA_VS_O = ~vga_VS;

  assign VGA_R = inDisplayArea ? {vbyte[5:4], 6'b000000} : 8'b00000000;
  assign VGA_G = inDisplayArea ? {vbyte[3:2], 6'b000000} : 8'b00000000;
  assign VGA_B = inDisplayArea ? {vbyte[1:0], 6'b000000} : 8'b00000000;  
endmodule