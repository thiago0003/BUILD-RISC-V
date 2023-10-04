module RISCV(
	input wire clock,
	input wire reset
	);
	
	logic [31:0]pc;
	logic [31:0]next_pc;
	logic [31:0]alu_result;
	logic [31:0]instruction;
	
	assign next_pc =	reset     				? 32'b0:
							is_conditional_jump	? jump_add:
							$signed(pc) + 32'd4;
						  
	always_ff @(posedge clock) begin
		pc <= next_pc[31:0];
	end
	
	logic [6:0] opcode;
	assign opcode = instruction[6:0];
	logic [4:0] rd_;
	assign rd_ = instruction[11:7];
	logic [2:0] funct3_;
	assign funct3_ = instruction[14:12];
	logic [4:0] rs1_;
	assign rs1_ = instruction[19:15];
	logic [4:0] rs2_;
	assign rs2_ = instruction[24:20];
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
	assign RD = (R_type | I_type | U_type | J_type) ? rd_ : 5'b0;
	
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
	
	//logic is_lw;
	//assign is_lw     = (opcode == 7'b0000011 & funct3 == 3'b010);
	
	logic is_conditional_jump;
	assign is_conditional_jump = (is_beq || is_bne || is_blt || is_bge || is_jal || is_jalr);
	
	// ALU
	logic [31:0] result;
	assign result = 	is_add   ? $signed(RS1) + $signed(RS2):
							is_addi  ? $signed(RS1) + $signed(imm):
							is_slli  ? RS1 << imm[4:0]:
							is_auipc ? pc + $signed(imm):
							is_jal   ? pc + 32'd4:
							is_jalr  ? pc + 32'd4:
							S_type 	? $signed(RS1) + $signed(imm): 
							32'b0;
	
	logic [31:0] jump_add;
	assign jump_add =	is_jal  													? $signed(pc) + $signed($signed(imm) >>> 2):
							is_jalr 													? $signed(pc) + $signed(RS1) + $signed($signed(imm) >>> 2):
							(is_beq && (RS1 == RS2)) 							? $signed(pc) + $signed($signed(imm) >>> 2):
							(is_bne && (RS1 != RS2))							? $signed(pc) + $signed($signed(imm) >>> 2):
							(is_blt && ($signed(RS1) < $signed(RS2)))		? $signed(pc) + $signed($signed(imm) >>> 2):
							(is_bge && ($signed(RS1) >= $signed(RS2)))	? $signed(pc) + $signed($signed(imm) >>> 2):
							pc + 32'd4;
		
		always @(posedge clock) begin
				alu_result <= result;
		end
		
	// Registers
	logic rd_valid;
	assign rd_valid = R_type || I_type || U_type || J_type && (rd_!=5'b0);

	logic [32-1:0] ld_data;
	logic [4:0] rs1;
	logic [4:0] rs2; 
	 
	regfile regs(clock, rd_valid, rs1_, rs2_, RD, is_lw ? ld_data : alu_result, rs1, rs2);


	// Memoria 
	imem imem(pc, instruction)
	dmem dmem(clock, is_sw, alu_result[6:2], rs2, ld_data);
	
	
endmodule


// Modulo de memoria

module dmem(input  logic        clk, we,
            input  logic [31:0] a, wd,
            output logic [31:0] rd);

  logic [31:0] RAM[63:0];

  assign rd = RAM[a[31:2]]; // word aligned

  always_ff @(posedge clk)
    if (we) RAM[a[31:2]] <= wd;
endmodule

module imem(input  logic [31:0] a,
            output logic [31:0] rd);

  logic [31:0] RAM[63:0];

  initial
      $readmemh("fibo.hex",RAM);

  assign rd = RAM[a[31:2]]; // word aligned
endmodule


// Modulo de registradores
module regfile(input  logic        clock, 
               input  logic        reg_enable,
               input  logic [4:0]  reg_addr1, reg_addr2, addr, 
               input  logic [31:0] write_reg, 
               output logic [31:0] rd1, rd2);
					
  logic [31:0] rf[31:0];

	always_ff @(posedge clock) 
		if (reg_enable) 
			rf[addr] <= write_reg;	
			
		assign rd1 = (reg_addr1 != 0) ? rf[reg_addr1] : 0;
		assign rd2 = (reg_addr2 != 0) ? rf[reg_addr2] : 0;
endmodule
