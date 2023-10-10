module vga_ (
  input clk,
  output [7:0] vaddr,
  output reg vga_HS, vga_VS, vga_DA);

  reg [9:0] CounterX, CounterY;
  wire CounterXmaxed = (CounterX == 800);
  wire CounterYmaxed = (CounterY == 525);
  
  wire [3:0] row, col;
  
  assign row = (CounterY>>6);
  assign col = (CounterX>>6);
  assign vaddr = (vaddr > 207) ? 8'b10000000 : {1'b1,col[3:0],row[2:0]}; 
  
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
		  
    vga_HS <= ~(CounterX > (640 + 16) && (CounterX < (640 + 16 + 96)));
    vga_VS <= ~(CounterY > (480 + 10) && (CounterY < (480 + 10 +  2)));
    vga_DA <= (CounterX < 640) && (CounterY < 480);
  end
endmodule