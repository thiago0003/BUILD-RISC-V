module mem #(
  parameter int BYTE_WIDTH = 8,
             ADDRESS_WIDTH = 10,
						   BYTES = 4,
		        DATA_WIDTH_R = BYTE_WIDTH * BYTES
)
(
	input [ADDRESS_WIDTH-1:0] addr1,
	input [ADDRESS_WIDTH-1:0] addr2,
	input [BYTES-1:0] be1,
	input [BYTES-1:0] be2,
	input [DATA_WIDTH_R-1:0] data_in1, 
	input [DATA_WIDTH_R-1:0] data_in2, 
	input we1, we2, clk,
	output [DATA_WIDTH_R-1:0] data_out1,
	output [DATA_WIDTH_R-1:0] data_out2);
	localparam RAM_DEPTH = 1 << ADDRESS_WIDTH;

	// model the RAM with two dimensional packed array
	logic [BYTES-1:0][BYTE_WIDTH-1:0] ram[0:RAM_DEPTH-1];

	reg [DATA_WIDTH_R-1:0] data_reg1;
	reg [DATA_WIDTH_R-1:0] data_reg2;

  initial
    $readmemh("mem.txt", ram);
	// port A
	always@(posedge clk)
	begin
		if(we1) begin
		// edit this code if using other than four bytes per word
			if(be1[0]) ram[addr1][0] <= data_in1[ 7: 0];
			if(be1[1]) ram[addr1][1] <= data_in1[15: 8];
			if(be1[2]) ram[addr1][2] <= data_in1[23:16];
			if(be1[3]) ram[addr1][3] <= data_in1[31:24];
		end
	data_reg1 <= ram[addr1[8:2]];
	end

	assign data_out1 = data_reg1;
   
	// port B
	always@(posedge clk)
	begin
		if(we2) begin
		// edit this code if using other than four bytes per word
			if(be2[0]) ram[addr2][0] <= data_in2[ 7: 0];
			if(be2[1]) ram[addr2][1] <= data_in2[15: 8];
			if(be2[2]) ram[addr2][2] <= data_in2[23:16];
			if(be2[3]) ram[addr2][3] <= data_in2[31:24];
		end
	data_reg2 <= ram[addr2[8:2]];
	end

	assign data_out2 = data_reg2;
endmodule 
