module RISCV(
	input wire clk,
	input wire rst,
	input wire [31:0] instruction
	);
	
	logic reset;
	logic [31:0]pc;
	logic [31:0]next_pc_wire;
	logic [31:0]next_pc;
	logic [31:0]alu_result;

	assign reset = rst;
	assign next_pc =	rst     					? 32'b0:
							is_conditional_jump	? jump_add:
							pc + 32'd4;
						  
	always_ff @(posedge clk) begin
		next_pc_wire[31:0] <= next_pc[31:0];
	end
	
	assign pc[31:0] = next_pc_wire;
	
	logic [6:0] opcode;
	assign opcode = instruction[6:0];
	logic [4:0] rd;
	assign rd = instruction[11:7];
	logic [2:0] funct3_;
	assign funct3_ = instruction[14:12];
	logic [4:0] rs1;
	assign rs1 = instruction[19:15];
	logic [4:0] rs2;
	assign rs2 = instruction[24:20];
	logic [6:0] funct7_;
	assign funct7_ = instruction[31:25];
	
	/*
		R_type Instructions
			ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
		I_type Instructions
			ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SSLI, SRLI, SRAI
		S_type Instructions
			SB, SH, SW
		B_type Instructions
			BEQ, BNE, BLT, BGE, BLTU, BGEU
		U_type Instructions
			LUI, AUIPC
		J_type Instructions
			JAL
	*/
	
	//Instruction Type 
	logic R_type;
	assign R_type = (opcode == 7'b0110011);
	
	logic I_type;
	assign I_type = (opcode == 7'b1100111 | opcode == 7'b0000011 | opcode == 7'b0010011); //Tambem seria uma instruçao do tipo I para 64bits => 0010011
	
	logic S_type;
	assign S_type = (opcode == 7'b0100011); //Tambem seria uma instruçao do tipo S para Double ou Float => 0100111
	
	logic B_type;
	assign B_type = (opcode == 7'b1100011);
	
	logic U_type;
	assign U_type = (opcode == 7'b0110111 | opcode == 7'b0010111);
	
	logic J_type;
	assign J_type = (opcode == 7'b1101111);
	
	// decode the instruction components
	logic [4:0] RS1;
	assign RS1 = (R_type | I_type | S_type | B_type) ? rs1 : 5'b0;
	
	logic [4:0] RS2;
	assign RS2 = (R_type | S_type | B_type)          ? rs2 : 5'b0;

	logic [4:0] RD;
	assign RD = (R_type | I_type | U_type | J_type) ? rd : 5'b0;
	
	logic [2:0] funct3;
	assign funct3 = (R_type | I_type | S_type | B_type) ? funct3_ : 3'b0;
	
	logic [6:0] funct7;
	assign funct7 = (R_type)                            ? funct7_ : 7'b0;
	
	logic [31:0] imm;
	assign imm   = 	(I_type) ? ({{20{instruction[31]}},instruction[31:20]}):
							(S_type)	? ({{20{instruction[31]}},instruction[31:25],instruction[11:7]}):		
							(B_type) ? ({{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0}):
							(U_type) ? ({instruction[31:12],12'b0}):
							(J_type) ? ({{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:21],1'b0}):
							32'b0;
	logic is_add;
	assign is_add    = (opcode == 7'b0110011 & funct3 == 3'b000 & funct7 == 7'b0000000);
	
	logic is_addi;
	assign is_addi   = (opcode == 7'b0010011 & funct3 == 3'b000);
	
	logic is_slli;
	assign is_slli   = (opcode == 7'b0010011 & funct3 == 3'b001 & funct7 == 7'b0000000);
	
	logic is_auipc;
	assign is_auipc  = (opcode == 7'b0010111);
	
	logic is_jal;
	assign is_jal    = (opcode == 7'b1101111);
	
	logic is_jalr;
	assign is_jalr   = (opcode == 7'b1100111 & funct3 == 3'b0);
	
	logic is_bge;
	assign is_bge    = (opcode == 7'b1100011 & funct3 == 3'b101);
	
	logic is_beq;
	assign is_beq    = (opcode == 7'b1100011 & funct3 == 3'b0);
	
	logic is_blt;
	assign is_blt    = (opcode == 7'b1100011 & funct3 == 3'b100);
	
	logic is_bne;
	assign is_bne    = (opcode == 7'b1100011 & funct3 == 3'b001);
	
	logic is_sw;
	assign is_sw     = (opcode == 7'b0100011 & funct3 == 3'b010);
	
	logic is_lw;
	assign is_lw     = (opcode == 7'b0000011 & funct3 == 3'b010);
	
	logic is_conditional_jump;
	assign is_conditional_jump = (is_beq || is_bne || is_blt || is_bge || is_jal || is_jalr);
	
	// ALU
	logic [31:0] result;
	assign result = 	is_add   ? $signed(RS1) + $signed(RS2):
							is_addi  ? $signed(RS1) + $signed(imm):
							is_slli  ? RS1 << imm[4:0]:
							is_auipc ? pc + $signed(imm):
							is_jal   ? pc + 1:
							is_jalr  ? pc + 1:
							32'b0;
	
	logic [31:0] jump_add;
	assign jump_add =	is_jal  													? $signed(pc) + $signed($signed(imm) >>> 2):
							is_jalr 													? $signed(RS1) + $signed($signed(imm) >>> 2):
							(is_beq && (RS1 == RS2)) 							? $signed(pc) + $signed($signed(imm) >>> 2):
							(is_bne && (RS1 != RS2))							? $signed(pc) + $signed($signed(imm) >>> 2):
							(is_blt && ($signed(RS1) < $signed(RS2)))		? $signed(pc) + $signed($signed(imm) >>> 2):
							(is_bge && ($signed(RS1) >= $signed(RS2)))	? $signed(pc) + $signed($signed(imm) >>> 2):
							pc + 1;
		
		always @(posedge clk) begin
				alu_result <= result;
		end

	
endmodule