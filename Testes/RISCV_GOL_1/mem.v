// Modulo de memoria de programa 
module dmem(
  input 			  clk, mem_write,
	input  [31:0] addr,
	input  [ 8:0] vaddr,
	input  [31:0] write_data,
	output [31:0] read_data,
	output [31:0] vdata);

  reg [31:0] RAM [0:127];

  initial
    $readmemh("dmem.hex", RAM);

  assign vdata = RAM[vaddr[8:2]]; // word aligned
  assign read_data = RAM[addr[31:2]]; // word aligned
  
  always @(posedge clk) 
    if (mem_write) 
  		RAM[addr[31:2]] <= write_data;
endmodule

// Modulo de memoria das instruçoes
module imem(
  input [31:0] pc,
  output [31:0] instr);

  reg [31:0] RAM[0:63];

  initial begin
    $readmemh("imem.hex", RAM);
   end
  assign instr = RAM[pc[31:2]]; // word aligned
endmodule