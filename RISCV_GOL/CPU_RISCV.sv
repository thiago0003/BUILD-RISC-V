// Nosso processador 
module RISCV(
			  input  logic        clk, reset,
           output logic [31:0] pc,
           input  logic [31:0] instruction,
           output logic        mem_write,
           output logic [31:0] alu_result, write_data,
           input  logic [31:0] read_data
	);

	// Registradores
	logic [31:0]src1;
	logic [31:0]src2;

	//JUMP
	logic is_conditional_jump;
	logic [31:0] jump_add;

	//PC
	logic [31:0]next_pc;
	
	// Atualiza nosso valor de PC
	assign next_pc =	reset     				? 32'b0:
							is_conditional_jump	? jump_add:
							pc + 32'd4;
						  
	always_ff @(posedge clk) begin
		pc <= next_pc[31:0];
	end
	
	// Recebe os valores que sao passados na instruçao
	logic [6:0] opcode;
	assign opcode = instruction[6:0];
	logic [4:0] rd_;
	assign rd_ = instruction[11:7];
	logic [2:0] funct3_;
	assign funct3_ = instruction[14:12];
	logic [4:0] rs1;
	assign rs1 = instruction[19:15];
	logic [4:0] rs2;
	assign rs2 = instruction[24:20];
	logic [6:0] funct7_;
	assign funct7_ = instruction[31:25];
	
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
	
	// Decodificaçao das instruçoes e seus respectivos tipos 
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
					(S_type) ? ({{20{instruction[31]}},instruction[31:25],instruction[11:7]}):		
					(B_type) ? ({{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0}):
					(U_type) ? ({instruction[31:12],12'b0}):
					(J_type) ? ({{11{instruction[31]}}, instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0}):
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
	
	logic is_lui;
	assign is_lui	  = (opcode == 7'b0110111);
	
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
	
	logic is_xor;
	assign is_xor	 = (opcode == 7'b0110011 & funct3 == 3'b100);
	
	logic is_slri;
	assign is_slri	 = (opcode == 7'b0010011 & funct3 == 3'b101);
	
	logic is_sb;
	assign is_sb	= (opcode == 7'b0100011 & funct3 == 3'b000);
	
	logic is_lbu;
	assign is_lbu	= (opcode == 7'b0000011 & funct3 == 3'b100);
	
	// Condicional para sabermos se havera um JUMP 
	assign is_conditional_jump = (is_beq || is_bne || is_blt || is_bge || is_jal || is_jalr);
	
	// ALU
	logic [31:0] result;
	assign result = 	is_add   	? $signed(src1) + $signed(src2):
							is_addi		? $signed(src1) + $signed(imm):
							is_slli		? $signed(src1) << imm[4:0]:
							is_slri		? $signed(src1) << imm[4:0]:
							is_auipc		? pc + $signed(imm):
							J_type   	? jump_add:
							S_type 		? $signed(src1) + $signed(imm): 
							is_lw			? $signed(src1) + $signed(imm): 
							is_sw			? $signed(src1) + $signed(imm): 
							is_lui		? $signed(imm):
							is_xor		? $signed(src1) ^ $signed(src2):
							is_lbu		? $signed(src1) + $signed(imm):
							32'b0;
							
	// Recebe o resultado da alu.
	always_comb
		alu_result <= result;
	
	// Caso nossa instruçao seja de JUMP, temos que calcular a nova posiçao para nosso PC.
	assign jump_add =	is_jal  													? $signed(pc) 		+ $signed(imm):
							is_jalr 													? $signed(src1) 	+ $signed(imm):
							(is_beq && (src1 == src2)) 						? $signed(pc) 		+ $signed(imm) :
							(is_bne && (src1 != src2))							? $signed(pc) 		+ $signed(imm):
							(is_blt && ($signed(src1) < $signed(src2)))	? $signed(pc) 		+ $signed(imm):
							(is_bge && ($signed(src1) >= $signed(src2)))	? $signed(pc) 		+ $signed(imm):
							pc + 32'd4;

	// Valor que sera salvo na nossa memoria e a condicional de escrita
	assign write_data = is_sw ? src2 : (is_sb ? {{24{imm[31]}}, src2[7:0]} : 32'bX);
	assign mem_write = S_type;
		
	// Condicional para escrita nos registradores
	logic reg_write;
	assign reg_write = (R_type || S_type || B_type || I_type || U_type) && RD != 5'b0;
	
	regfile regs(clk, reg_write, RS1, RS2, RD, (is_lw || is_lbu) ?  read_data: alu_result, src1, src2);
	
endmodule

// Modulo de registradores
module regfile(input  logic        clk, 
               input  logic        reg_write,
               input  logic [4:0]  reg_addr1, reg_addr2, addr, 
               input  logic [31:0] write_reg, 
               output logic [31:0] rd1, rd2);
					
  logic [31:0] rf[31:0];

	always_ff @(posedge clk) 
		if (reg_write) 
			rf[addr] <= write_reg;	
		
	assign rd1 = (reg_addr1 != 32'b0) ? rf[reg_addr1] : 32'b0; 
	assign rd2 = (reg_addr2 != 32'b0) ? rf[reg_addr2] : 32'b0;
endmodule