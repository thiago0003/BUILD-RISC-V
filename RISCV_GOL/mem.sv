// Modulo de memoria de programa 
module dmem(input clk, mem_write,
				input  [31:0] addr, vaddr, write_data,
				output [31:0] read_data,
				output [31:0] vdata);

  reg [31:0] RAM[1000:0];

  initial
  begin
    RAM[0] =	32'b00000000000000000000000000111111;
    RAM[1] =	32'b00000000000000000000000000111111;
    RAM[2] =	32'b00000000000000000000000000111111;
    RAM[3] =	32'b00000000000000000000000000111111;
    RAM[4] =	32'b00000000000000000000000000111111;
    RAM[5] =	32'b00000000000000000000000000111111;
    RAM[6] =	32'b00000000000000000000000000111111;
    RAM[7] =	32'b00000000000000000000000000110000;
    RAM[8] =	32'b00000000000000000000000000110000;
    RAM[9] =	32'b00000000000000000000000000110000;
    RAM[10] =	32'b00000000000000000000000000110000;
    RAM[11] =	32'b00000000000000000000000000110000;
    RAM[12] =	32'b00000000000000000000000000111111;
    RAM[13] =	32'b00000000000000000000000000111111;
    RAM[14] =	32'b00000000000000000000000000111000;
    RAM[15] =	32'b00000000000000000000000000111000;
    RAM[16] =	32'b00000000000000000000000000111000;
    RAM[17] =	32'b00000000000000000000000000111111;
    RAM[18] =	32'b00000000000000000000000000111111;
    RAM[19] =	32'b00000000000000000000000000111111;
    RAM[20] =	32'b00000000000000000000000000111111;
    RAM[21] =	32'b00000000000000000000000000111111;
    RAM[22] =	32'b00000000000000000000000000111111;
    RAM[23] =	32'b00000000000000000000000000111111;
    RAM[24] =	32'b00000000000000000000000000111111;
    RAM[25] =	32'b00000000000000000000000000111111;
    RAM[26] =	32'b00000000000000000000000000110000;
    RAM[27] =	32'b00000000000000000000000000110000;
    RAM[28] =	32'b00000000000000000000000000110000;
    RAM[29] =	32'b00000000000000000000000000110000;
    RAM[30] =	32'b00000000000000000000000000110000;
    RAM[31] =	32'b00000000000000000000000000110000;
    RAM[32] =	32'b00000000000000000000000000110000;
    RAM[33] =	32'b00000000000000000000000000110000;
    RAM[34] =	32'b00000000000000000000000000110000;
    RAM[35] =	32'b00000000000000000000000000111000;
    RAM[36] =	32'b00000000000000000000000000111000;
    RAM[37] =	32'b00000000000000000000000000111111;
    RAM[38] =	32'b00000000000000000000000000111111;
    RAM[39] =	32'b00000000000000000000000000111111;
    RAM[40] =	32'b00000000000000000000000000111111;
    RAM[41] =	32'b00000000000000000000000000111111;
    RAM[42] =	32'b00000000000000000000000000111111;
    RAM[43] =	32'b00000000000000000000000000111111;
    RAM[44] =	32'b00000000000000000000000000111111;
    RAM[45] =	32'b00000000000000000000000000111111;
    RAM[46] =	32'b00000000000000000000000000010000;
    RAM[47] =	32'b00000000000000000000000000010000;
    RAM[48] =	32'b00000000000000000000000000010000;
    RAM[49] =	32'b00000000000000000000000000111000;
    RAM[50] =	32'b00000000000000000000000000111000;
    RAM[51] =	32'b00000000000000000000000000000000;
    RAM[52] =	32'b00000000000000000000000000111000;
    RAM[53] =	32'b00000000000000000000000000110000;
    RAM[54] =	32'b00000000000000000000000000110000;
    RAM[55] =	32'b00000000000000000000000000110000;
    RAM[56] =	32'b00000000000000000000000000110000;
    RAM[57] =	32'b00000000000000000000000000111111;
    RAM[58] =	32'b00000000000000000000000000111111;
    RAM[59] =	32'b00000000000000000000000000111111;
    RAM[60] =	32'b00000000000000000000000000111111;
    RAM[61] =	32'b00000000000000000000000000111111;
    RAM[62] =	32'b00000000000000000000000000111111;
    RAM[63] =	32'b00000000000000000000000000111111;
    RAM[64] =	32'b00000000000000000000000000111111;
    RAM[65] =	32'b00000000000000000000000000010000;
    RAM[66] =	32'b00000000000000000000000000111000;
    RAM[67] =	32'b00000000000000000000000000010000;
    RAM[68] =	32'b00000000000000000000000000111000;
    RAM[69] =	32'b00000000000000000000000000111000;
    RAM[70] =	32'b00000000000000000000000000111000;
    RAM[71] =	32'b00000000000000000000000000000000;
    RAM[72] =	32'b00000000000000000000000000111000;
    RAM[73] =	32'b00000000000000000000000000111000;
    RAM[74] =	32'b00000000000000000000000000111000;
    RAM[75] =	32'b00000000000000000000000000110000;
    RAM[76] =	32'b00000000000000000000000000110000;
    RAM[77] =	32'b00000000000000000000000000111111;
    RAM[78] =	32'b00000000000000000000000000111111;
    RAM[79] =	32'b00000000000000000000000000111111;
    RAM[80] =	32'b00000000000000000000000000111111;
    RAM[81] =	32'b00000000000000000000000000111111;
    RAM[82] =	32'b00000000000000000000000000111111;
    RAM[83] =	32'b00000000000000000000000000111111;
    RAM[84] =	32'b00000000000000000000000000111111;
    RAM[85] =	32'b00000000000000000000000000010000;
    RAM[86] =	32'b00000000000000000000000000111000;
    RAM[87] =	32'b00000000000000000000000000010000;
    RAM[88] =	32'b00000000000000000000000000010000;
    RAM[89] =	32'b00000000000000000000000000111000;
    RAM[90] =	32'b00000000000000000000000000111000;
    RAM[91] =	32'b00000000000000000000000000111000;
    RAM[92] =	32'b00000000000000000000000000000000;
    RAM[93] =	32'b00000000000000000000000000111000;
    RAM[94] =	32'b00000000000000000000000000111000;
    RAM[95] =	32'b00000000000000000000000000111000;
    RAM[96] =	32'b00000000000000000000000000110000;
    RAM[97] =	32'b00000000000000000000000000111111;
    RAM[98] =	32'b00000000000000000000000000111111;
    RAM[99] =	32'b00000000000000000000000000111111;
    RAM[100] =	32'b00000000000000000000000000111111;
    RAM[101] =	32'b00000000000000000000000000111111;
    RAM[102] =	32'b00000000000000000000000000111111;
    RAM[103] =	32'b00000000000000000000000000111111;
    RAM[104] =	32'b00000000000000000000000000111111;
    RAM[105] =	32'b00000000000000000000000000010000;
    RAM[106] =	32'b00000000000000000000000000010000;
    RAM[107] =	32'b00000000000000000000000000111000;
    RAM[108] =	32'b00000000000000000000000000111000;
    RAM[109] =	32'b00000000000000000000000000111000;
    RAM[110] =	32'b00000000000000000000000000111000;
    RAM[111] =	32'b00000000000000000000000000000000;
    RAM[112] =	32'b00000000000000000000000000000000;
    RAM[113] =	32'b00000000000000000000000000000000;
    RAM[114] =	32'b00000000000000000000000000000000;
    RAM[115] =	32'b00000000000000000000000000000000;
    RAM[116] =	32'b00000000000000000000000000111111;
    RAM[117] =	32'b00000000000000000000000000111111;
    RAM[118] =	32'b00000000000000000000000000111111;
    RAM[119] =	32'b00000000000000000000000000111111;
    RAM[120] =	32'b00000000000000000000000000111111;
    RAM[121] =	32'b00000000000000000000000000111111;
    RAM[122] =	32'b00000000000000000000000000111111;
    RAM[123] =	32'b00000000000000000000000000111111;
    RAM[124] =	32'b00000000000000000000000000111111;
    RAM[125] =	32'b00000000000000000000000000111111;
    RAM[126] =	32'b00000000000000000000000000111111;
    RAM[127] =	32'b00000000000000000000000000111000;
    RAM[128] =	32'b00000000000000000000000000111000;
    RAM[129] =	32'b00000000000000000000000000111000;
    RAM[130] =	32'b00000000000000000000000000111000;
    RAM[131] =	32'b00000000000000000000000000111000;
    RAM[132] =	32'b00000000000000000000000000111000;
    RAM[133] =	32'b00000000000000000000000000111000;
    RAM[134] =	32'b00000000000000000000000000110000;
    RAM[135] =	32'b00000000000000000000000000110000;
    RAM[136] =	32'b00000000000000000000000000111111;
    RAM[137] =	32'b00000000000000000000000000111111;
    RAM[138] =	32'b00000000000000000000000000111111;
    RAM[139] =	32'b00000000000000000000000000111111;
    RAM[140] =	32'b00000000000000000000000000111111;
    RAM[141] =	32'b00000000000000000000000000111111;
    RAM[142] =	32'b00000000000000000000000000111111;
    RAM[143] =	32'b00000000000000000000000000111111;
    RAM[144] =	32'b00000000000000000000000000110000;
    RAM[145] =	32'b00000000000000000000000000110000;
    RAM[146] =	32'b00000000000000000000000000110000;
    RAM[147] =	32'b00000000000000000000000000110000;
    RAM[148] =	32'b00000000000000000000000000000011;
    RAM[149] =	32'b00000000000000000000000000110000;
    RAM[150] =	32'b00000000000000000000000000110000;
    RAM[151] =	32'b00000000000000000000000000110000;
    RAM[152] =	32'b00000000000000000000000000000011;
    RAM[153] =	32'b00000000000000000000000000110000;
    RAM[154] =	32'b00000000000000000000000000110000;
    RAM[155] =	32'b00000000000000000000000000111111;
    RAM[156] =	32'b00000000000000000000000000111111;
    RAM[157] =	32'b00000000000000000000000000010000;
    RAM[158] =	32'b00000000000000000000000000111111;
    RAM[159] =	32'b00000000000000000000000000111111;
    RAM[160] =	32'b00000000000000000000000000111111;
    RAM[161] =	32'b00000000000000000000000000111111;
    RAM[162] =	32'b00000000000000000000000000111000;
    RAM[163] =	32'b00000000000000000000000000111000;
    RAM[164] =	32'b00000000000000000000000000110000;
    RAM[165] =	32'b00000000000000000000000000110000;
    RAM[166] =	32'b00000000000000000000000000110000;
    RAM[167] =	32'b00000000000000000000000000110000;
    RAM[168] =	32'b00000000000000000000000000110000;
    RAM[169] =	32'b00000000000000000000000000000011;
    RAM[170] =	32'b00000000000000000000000000110000;
    RAM[171] =	32'b00000000000000000000000000110000;
    RAM[172] =	32'b00000000000000000000000000110000;
    RAM[173] =	32'b00000000000000000000000000000011;
    RAM[174] =	32'b00000000000000000000000000111111;
    RAM[175] =	32'b00000000000000000000000000111111;
    RAM[176] =	32'b00000000000000000000000000010000;
    RAM[177] =	32'b00000000000000000000000000010000;
    RAM[178] =	32'b00000000000000000000000000111111;
    RAM[179] =	32'b00000000000000000000000000111111;
    RAM[180] =	32'b00000000000000000000000000111111;
    RAM[181] =	32'b00000000000000000000000000111111;
    RAM[182] =	32'b00000000000000000000000000111000;
    RAM[183] =	32'b00000000000000000000000000111000;
    RAM[184] =	32'b00000000000000000000000000111000;
    RAM[185] =	32'b00000000000000000000000000110000;
    RAM[186] =	32'b00000000000000000000000000110000;
    RAM[187] =	32'b00000000000000000000000000110000;
    RAM[188] =	32'b00000000000000000000000000110000;
    RAM[189] =	32'b00000000000000000000000000000011;
    RAM[190] =	32'b00000000000000000000000000000011;
    RAM[191] =	32'b00000000000000000000000000000011;
    RAM[192] =	32'b00000000000000000000000000000011;
    RAM[193] =	32'b00000000000000000000000000111100;
    RAM[194] =	32'b00000000000000000000000000000011;
    RAM[195] =	32'b00000000000000000000000000000011;
    RAM[196] =	32'b00000000000000000000000000010000;
    RAM[197] =	32'b00000000000000000000000000010000;
    RAM[198] =	32'b00000000000000000000000000111111;
    RAM[199] =	32'b00000000000000000000000000111111;
    RAM[200] =	32'b00000000000000000000000000111111;
    RAM[201] =	32'b00000000000000000000000000111111;
    RAM[202] =	32'b00000000000000000000000000111111;
    RAM[203] =	32'b00000000000000000000000000111000;
    RAM[204] =	32'b00000000000000000000000000111111;
    RAM[205] =	32'b00000000000000000000000000111111;
    RAM[206] =	32'b00000000000000000000000000000011;
    RAM[207] =	32'b00000000000000000000000000000011;
    RAM[208] =	32'b00000000000000000000000000000011;
    RAM[209] =	32'b00000000000000000000000000000011;
    RAM[210] =	32'b00000000000000000000000000111100;
    RAM[211] =	32'b00000000000000000000000000000011;
    RAM[212] =	32'b00000000000000000000000000000011;
    RAM[213] =	32'b00000000000000000000000000000011;
    RAM[214] =	32'b00000000000000000000000000000011;
    RAM[215] =	32'b00000000000000000000000000000011;
    RAM[216] =	32'b00000000000000000000000000010000;
    RAM[217] =	32'b00000000000000000000000000010000;
    RAM[218] =	32'b00000000000000000000000000111111;
    RAM[219] =	32'b00000000000000000000000000111111;
    RAM[220] =	32'b00000000000000000000000000111111;
    RAM[221] =	32'b00000000000000000000000000111111;
    RAM[222] =	32'b00000000000000000000000000111111;
    RAM[223] =	32'b00000000000000000000000000111111;
    RAM[224] =	32'b00000000000000000000000000010000;
    RAM[225] =	32'b00000000000000000000000000010000;
    RAM[226] =	32'b00000000000000000000000000000011;
    RAM[227] =	32'b00000000000000000000000000000011;
    RAM[228] =	32'b00000000000000000000000000000011;
    RAM[229] =	32'b00000000000000000000000000000011;
    RAM[230] =	32'b00000000000000000000000000000011;
    RAM[231] =	32'b00000000000000000000000000000011;
    RAM[232] =	32'b00000000000000000000000000000011;
    RAM[233] =	32'b00000000000000000000000000000011;
    RAM[234] =	32'b00000000000000000000000000000011;
    RAM[235] =	32'b00000000000000000000000000000011;
    RAM[236] =	32'b00000000000000000000000000010000;
    RAM[237] =	32'b00000000000000000000000000010000;
    RAM[238] =	32'b00000000000000000000000000111111;
    RAM[239] =	32'b00000000000000000000000000111111;
    RAM[240] =	32'b00000000000000000000000000111111;
    RAM[241] =	32'b00000000000000000000000000111111;
    RAM[242] =	32'b00000000000000000000000000111111;
    RAM[243] =	32'b00000000000000000000000000010000;
    RAM[244] =	32'b00000000000000000000000000010000;
    RAM[245] =	32'b00000000000000000000000000010000;
    RAM[246] =	32'b00000000000000000000000000000011;
    RAM[247] =	32'b00000000000000000000000000000011;
    RAM[248] =	32'b00000000000000000000000000000011;
    RAM[249] =	32'b00000000000000000000000000000011;
    RAM[250] =	32'b00000000000000000000000000000011;
    RAM[251] =	32'b00000000000000000000000000000011;
    RAM[252] =	32'b00000000000000000000000000111111;
    RAM[253] =	32'b00000000000000000000000000111111;
    RAM[254] =	32'b00000000000000000000000000111111;
    RAM[255] =	32'b00000000000000000000000000111111;
    RAM[256] =	32'b00000000000000000000000000111111;
    RAM[257] =	32'b00000000000000000000000000111111;
    RAM[258] =	32'b00000000000000000000000000111111;
    RAM[259] =	32'b00000000000000000000000000111111;
    RAM[260] =	32'b00000000000000000000000000111111;
    RAM[261] =	32'b00000000000000000000000000111111;
    RAM[262] =	32'b00000000000000000000000000111111;
    RAM[263] =	32'b00000000000000000000000000010000;
    RAM[264] =	32'b00000000000000000000000000010000;
    RAM[265] =	32'b00000000000000000000000000111111;
    RAM[266] =	32'b00000000000000000000000000111111;
    RAM[267] =	32'b00000000000000000000000000111111;
    RAM[268] =	32'b00000000000000000000000000111111;
    RAM[269] =	32'b00000000000000000000000000111111;
    RAM[270] =	32'b00000000000000000000000000111111;
    RAM[271] =	32'b00000000000000000000000000111111;
    RAM[272] =	32'b00000000000000000000000000111111;
    RAM[273] =	32'b00000000000000000000000000111111;
    RAM[274] =	32'b00000000000000000000000000111111;
    RAM[275] =	32'b00000000000000000000000000111111;
    RAM[276] =	32'b00000000000000000000000000111111;
    RAM[277] =	32'b00000000000000000000000000111111;
    RAM[278] =	32'b00000000000000000000000000111111;
    RAM[279] =	32'b00000000000000000000000000111111;
    RAM[280] =	32'b00000000000000000000000000111111;
    RAM[281] =	32'b00000000000000000000000000111111;
    RAM[282] =	32'b00000000000000000000000000111111;
    RAM[283] =	32'b00000000000000000000000000111111;
    RAM[284] =	32'b00000000000000000000000000111111;
    RAM[285] =	32'b00000000000000000000000000111111;
    RAM[286] =	32'b00000000000000000000000000111111;
    RAM[287] =	32'b00000000000000000000000000111111;
    RAM[288] =	32'b00000000000000000000000000111111;
    RAM[289] =	32'b00000000000000000000000000111111;
    RAM[290] =	32'b00000000000000000000000000111111;
    RAM[291] =	32'b00000000000000000000000000111111;
    RAM[292] =	32'b00000000000000000000000000111111;
    RAM[293] =	32'b00000000000000000000000000111111;
    RAM[294] =	32'b00000000000000000000000000000011;
    RAM[295] =	32'b00000000000000000000000000001100;
    RAM[296] =	32'b00000000000000000000000000110000;
    RAM[297] =	32'b00000000000000000000000000111100;
    RAM[298] =	32'b00000000000000000000000000110011;
    RAM[299] =	32'b00000000000000000000000000001111;
  end

  assign vdata = RAM[vaddr[31:0]]; 
  assign read_data = RAM[addr[31:2]]; // word aligned
  
  always_ff @(posedge clk) 
    if (mem_write) 
	 begin
		RAM[addr[31:2]] 		<= write_data;
	end
endmodule


// Modulo de memoria das instruçoes
module imem(input  logic [31:0] pc,
            output logic [31:0] instr);

  logic [31:0] RAM[511:0];

  initial
  begin
			RAM[0] =32'h00000093;
			RAM[1] =32'h00000113;
			RAM[2] =32'h00000193;
			RAM[3] =32'h00000213;
			RAM[4] =32'h00000293;
			RAM[5] =32'h00000313;
			RAM[6] =32'h00000393;
			RAM[7] =32'h00000413;
			RAM[8] =32'h00000493;
			RAM[9] =32'h00000513;
			RAM[10] =32'h00000593;
			RAM[11] =32'h00000613;
			RAM[12] =32'h00000693;
			RAM[13] =32'h00000713;
			RAM[14] =32'h00000793;
			RAM[15] =32'h00000813;
			RAM[16] =32'h00000893;
			RAM[17] =32'h00000913;
			RAM[18] =32'h00000993;
			RAM[19] =32'h00000a13;
			RAM[20] =32'h00000a93;
			RAM[21] =32'h00000b13;
			RAM[22] =32'h00000b93;
			RAM[23] =32'h00000c13;
			RAM[24] =32'h00000c93;
			RAM[25] =32'h00000d13;
			RAM[26] =32'h00000d93;
			RAM[27] =32'h00000e13;
			RAM[28] =32'h00000e93;
			RAM[29] =32'h40010113;
			RAM[30] =32'h02112623;
			RAM[31] =32'h02812423;
			RAM[32] =32'h02912223;
			RAM[33] =32'h03010413;
			RAM[34] =32'hfca42e23;
			RAM[35] =32'hfcb42c23;
			RAM[36] =32'h11000493;
			RAM[37] =32'hfe042623;
			RAM[38] =32'h0700006f;
			RAM[39] =32'hfe042423;
			RAM[40] =32'h0500006f;
			RAM[41] =32'h00900533;
			RAM[42] =32'h00000317;
			RAM[43] =32'h684300e7;
			RAM[44] =32'h00a006b3;
			RAM[45] =32'hfe842783;
			RAM[46] =32'h00579713;
			RAM[47] =32'hfe842783;
			RAM[48] =32'h00179793;
			RAM[49] =32'h40f70733;
			RAM[50] =32'hfec42783;
			RAM[51] =32'h00f707b3;
			RAM[52] =32'h0ff6f713;
			RAM[53] =32'h000006b7;
			RAM[54] =32'h00068693;
			RAM[55] =32'h00f687b3;
			RAM[56] =32'h00e78023;
			RAM[57] =32'hfe842783;
			RAM[58] =32'h00178793;
			RAM[59] =32'hfef42423;
			RAM[60] =32'hfe842703;
			RAM[61] =32'h01d00793;
			RAM[62] =32'hfae7d6e3;
			RAM[63] =32'hfec42783;
			RAM[64] =32'h00178793;
			RAM[65] =32'hfef42623;
			RAM[66] =32'hfec42703;
			RAM[67] =32'h01d00793;
			RAM[68] =32'hf8e7d6e3;
			RAM[69] =32'h06400513;
			RAM[70] =32'h00000013;
			RAM[71] =32'h00000013;
			RAM[72] =32'h00000013;
			RAM[73] =32'h00000013;
			RAM[74] =32'h00000317;
			RAM[75] =32'h020300e7;
			RAM[76] =32'h7d000513;
			RAM[77] =32'h00000013;
			RAM[78] =32'h00000013;
			RAM[79] =32'h00000013;
			RAM[80] =32'h00000013;
			RAM[81] =32'hfe5ff06f;
			RAM[82] =32'hf5010113;
			RAM[83] =32'h0a812623;
			RAM[84] =32'h0a912423;
			RAM[85] =32'h0b010413;
			RAM[86] =32'hfe042623;
			RAM[87] =32'h05c0006f;
			RAM[88] =32'h000007b7;
			RAM[89] =32'h00078713;
			RAM[90] =32'hfec42783;
			RAM[91] =32'h00f707b3;
			RAM[92] =32'h0007c703;
			RAM[93] =32'hfec42783;
			RAM[94] =32'hff078793;
			RAM[95] =32'h008787b3;
			RAM[96] =32'hf6e78423;
			RAM[97] =32'hfec42783;
			RAM[98] =32'h36678793;
			RAM[99] =32'h00000737;
			RAM[100] =32'h00070713;
			RAM[101] =32'h00f707b3;
			RAM[102] =32'h0007c703;
			RAM[103] =32'hfec42783;
			RAM[104] =32'hff078793;
			RAM[105] =32'h008787b3;
			RAM[106] =32'hf8e78423;
			RAM[107] =32'hfec42783;
			RAM[108] =32'h00178793;
			RAM[109] =32'hfef42623;
			RAM[110] =32'hfec42703;
			RAM[111] =32'h01d00793;
			RAM[112] =32'hfae7d0e3;
			RAM[113] =32'hfe042423;
			RAM[114] =32'h32c0006f;
			RAM[115] =32'hfe042223;
			RAM[116] =32'h2440006f;
			RAM[117] =32'hfe442783;
			RAM[118] =32'h00078863;
			RAM[119] =32'hfe442783;
			RAM[120] =32'hfff78793;
			RAM[121] =32'h0080006f;
			RAM[122] =32'h01d00793;
			RAM[123] =32'hff078793;
			RAM[124] =32'h008787b3;
			RAM[125] =32'hf887c703;
			RAM[126] =32'hfe442783;
			RAM[127] =32'hff078793;
			RAM[128] =32'h008787b3;
			RAM[129] =32'hf887c783;
			RAM[130] =32'h00f707b3;
			RAM[131] =32'h0ff7f713;
			RAM[132] =32'hfe442683;
			RAM[133] =32'h01d00793;
			RAM[134] =32'h00f68863;
			RAM[135] =32'hfe442783;
			RAM[136] =32'h00178793;
			RAM[137] =32'h0080006f;
			RAM[138] =32'h00000793;
			RAM[139] =32'hff078793;
			RAM[140] =32'h008787b3;
			RAM[141] =32'hf887c783;
			RAM[142] =32'h00f707b3;
			RAM[143] =32'h0ff7f713;
			RAM[144] =32'hfe842783;
			RAM[145] =32'h00579693;
			RAM[146] =32'hfe842783;
			RAM[147] =32'h00179793;
			RAM[148] =32'h40f686b3;
			RAM[149] =32'hfe442783;
			RAM[150] =32'h00078863;
			RAM[151] =32'hfe442783;
			RAM[152] =32'hfff78793;
			RAM[153] =32'h0080006f;
			RAM[154] =32'h01d00793;
			RAM[155] =32'h00d787b3;
			RAM[156] =32'h000006b7;
			RAM[157] =32'h00068693;
			RAM[158] =32'h00f687b3;
			RAM[159] =32'h0007c783;
			RAM[160] =32'h00f707b3;
			RAM[161] =32'h0ff7f713;
			RAM[162] =32'hfe842783;
			RAM[163] =32'h00579693;
			RAM[164] =32'hfe842783;
			RAM[165] =32'h00179793;
			RAM[166] =32'h40f686b3;
			RAM[167] =32'hfe442603;
			RAM[168] =32'h01d00793;
			RAM[169] =32'h00f60863;
			RAM[170] =32'hfe442783;
			RAM[171] =32'h00178793;
			RAM[172] =32'h0080006f;
			RAM[173] =32'h00000793;
			RAM[174] =32'h00d787b3;
			RAM[175] =32'h000006b7;
			RAM[176] =32'h00068693;
			RAM[177] =32'h00f687b3;
			RAM[178] =32'h0007c783;
			RAM[179] =32'h00f707b3;
			RAM[180] =32'h0ff7f713;
			RAM[181] =32'hfe842783;
			RAM[182] =32'h00178793;
			RAM[183] =32'h00579693;
			RAM[184] =32'hfe842783;
			RAM[185] =32'h00178793;
			RAM[186] =32'h00179793;
			RAM[187] =32'h40f686b3;
			RAM[188] =32'hfe442783;
			RAM[189] =32'h00078863;
			RAM[190] =32'hfe442783;
			RAM[191] =32'hfff78793;
			RAM[192] =32'h0080006f;
			RAM[193] =32'h01d00793;
			RAM[194] =32'h00d787b3;
			RAM[195] =32'h000006b7;
			RAM[196] =32'h00068693;
			RAM[197] =32'h00f687b3;
			RAM[198] =32'h0007c783;
			RAM[199] =32'h00f707b3;
			RAM[200] =32'h0ff7f713;
			RAM[201] =32'hfe842783;
			RAM[202] =32'h00178793;
			RAM[203] =32'h00579693;
			RAM[204] =32'hfe842783;
			RAM[205] =32'h00178793;
			RAM[206] =32'h00179793;
			RAM[207] =32'h40f686b3;
			RAM[208] =32'hfe442783;
			RAM[209] =32'h00f687b3;
			RAM[210] =32'h000006b7;
			RAM[211] =32'h00068693;
			RAM[212] =32'h00f687b3;
			RAM[213] =32'h0007c783;
			RAM[214] =32'h00f707b3;
			RAM[215] =32'h0ff7f713;
			RAM[216] =32'hfe842783;
			RAM[217] =32'h00178793;
			RAM[218] =32'h00579693;
			RAM[219] =32'hfe842783;
			RAM[220] =32'h00178793;
			RAM[221] =32'h00179793;
			RAM[222] =32'h40f686b3;
			RAM[223] =32'hfe442603;
			RAM[224] =32'h01d00793;
			RAM[225] =32'h00f60863;
			RAM[226] =32'hfe442783;
			RAM[227] =32'h00178793;
			RAM[228] =32'h0080006f;
			RAM[229] =32'h00000793;
			RAM[230] =32'h00d787b3;
			RAM[231] =32'h000006b7;
			RAM[232] =32'h00068693;
			RAM[233] =32'h00f687b3;
			RAM[234] =32'h0007c783;
			RAM[235] =32'h00f707b3;
			RAM[236] =32'h0ff7f493;
			RAM[237] =32'hfe842783;
			RAM[238] =32'h00579713;
			RAM[239] =32'hfe842783;
			RAM[240] =32'h00179793;
			RAM[241] =32'h40f70733;
			RAM[242] =32'hfe442783;
			RAM[243] =32'h00f707b3;
			RAM[244] =32'h00000737;
			RAM[245] =32'h00070713;
			RAM[246] =32'h00f707b3;
			RAM[247] =32'h0007c783;
			RAM[248] =32'h00f4e7b3;
			RAM[249] =32'h0ff7f793;
			RAM[250] =32'hffd78793;
			RAM[251] =32'h0017b793;
			RAM[252] =32'h0ff7f793;
			RAM[253] =32'h00f00733;
			RAM[254] =32'hfe442783;
			RAM[255] =32'hff078793;
			RAM[256] =32'h008787b3;
			RAM[257] =32'hfce78423;
			RAM[258] =32'hfe442783;
			RAM[259] =32'h00178793;
			RAM[260] =32'hfef42223;
			RAM[261] =32'hfe442703;
			RAM[262] =32'h01d00793;
			RAM[263] =32'hdae7dce3;
			RAM[264] =32'hfe042023;
			RAM[265] =32'h0b80006f;
			RAM[266] =32'hfe842783;
			RAM[267] =32'h00579713;
			RAM[268] =32'hfe842783;
			RAM[269] =32'h00179793;
			RAM[270] =32'h40f70733;
			RAM[271] =32'hfe042783;
			RAM[272] =32'h00f707b3;
			RAM[273] =32'h00000737;
			RAM[274] =32'h00070713;
			RAM[275] =32'h00f707b3;
			RAM[276] =32'h0007c703;
			RAM[277] =32'hfe042783;
			RAM[278] =32'hff078793;
			RAM[279] =32'h008787b3;
			RAM[280] =32'hf8e78423;
			RAM[281] =32'hfe842783;
			RAM[282] =32'h04f05463;
			RAM[283] =32'hfe842783;
			RAM[284] =32'hfff78793;
			RAM[285] =32'h00579713;
			RAM[286] =32'hfe842783;
			RAM[287] =32'hfff78793;
			RAM[288] =32'h00179793;
			RAM[289] =32'h40f70733;
			RAM[290] =32'hfe042783;
			RAM[291] =32'h00f707b3;
			RAM[292] =32'hfe042703;
			RAM[293] =32'hff070713;
			RAM[294] =32'h00870733;
			RAM[295] =32'hfa874703;
			RAM[296] =32'h000006b7;
			RAM[297] =32'h00068693;
			RAM[298] =32'h00f687b3;
			RAM[299] =32'h00e78023;
			RAM[300] =32'hfe042783;
			RAM[301] =32'hff078793;
			RAM[302] =32'h008787b3;
			RAM[303] =32'hfc87c703;
			RAM[304] =32'hfe042783;
			RAM[305] =32'hff078793;
			RAM[306] =32'h008787b3;
			RAM[307] =32'hfae78423;
			RAM[308] =32'hfe042783;
			RAM[309] =32'h00178793;
			RAM[310] =32'hfef42023;
			RAM[311] =32'hfe042703;
			RAM[312] =32'h01d00793;
			RAM[313] =32'hf4e7d2e3;
			RAM[314] =32'hfe842783;
			RAM[315] =32'h00178793;
			RAM[316] =32'hfef42423;
			RAM[317] =32'hfe842703;
			RAM[318] =32'h01c00793;
			RAM[319] =32'hcce7d8e3;
			RAM[320] =32'hfc042e23;
			RAM[321] =32'h1940006f;
			RAM[322] =32'hfdc42783;
			RAM[323] =32'h00078863;
			RAM[324] =32'hfdc42783;
			RAM[325] =32'hfff78793;
			RAM[326] =32'h0080006f;
			RAM[327] =32'h01d00793;
			RAM[328] =32'hff078793;
			RAM[329] =32'h008787b3;
			RAM[330] =32'hf887c703;
			RAM[331] =32'hfdc42783;
			RAM[332] =32'hff078793;
			RAM[333] =32'h008787b3;
			RAM[334] =32'hf887c783;
			RAM[335] =32'h00f707b3;
			RAM[336] =32'h0ff7f713;
			RAM[337] =32'hfdc42683;
			RAM[338] =32'h01d00793;
			RAM[339] =32'h00f68863;
			RAM[340] =32'hfdc42783;
			RAM[341] =32'h00178793;
			RAM[342] =32'h0080006f;
			RAM[343] =32'h00000793;
			RAM[344] =32'hff078793;
			RAM[345] =32'h008787b3;
			RAM[346] =32'hf887c783;
			RAM[347] =32'h00f707b3;
			RAM[348] =32'h0ff7f713;
			RAM[349] =32'hfdc42783;
			RAM[350] =32'h00078863;
			RAM[351] =32'hfdc42783;
			RAM[352] =32'h36578793;
			RAM[353] =32'h0080006f;
			RAM[354] =32'h38300793;
			RAM[355] =32'h000006b7;
			RAM[356] =32'h00068693;
			RAM[357] =32'h00f687b3;
			RAM[358] =32'h0007c783;
			RAM[359] =32'h00f707b3;
			RAM[360] =32'h0ff7f713;
			RAM[361] =32'hfdc42683;
			RAM[362] =32'h01d00793;
			RAM[363] =32'h00f68863;
			RAM[364] =32'hfdc42783;
			RAM[365] =32'h36778793;
			RAM[366] =32'h0080006f;
			RAM[367] =32'h36600793;
			RAM[368] =32'h000006b7;
			RAM[369] =32'h00068693;
			RAM[370] =32'h00f687b3;
			RAM[371] =32'h0007c783;
			RAM[372] =32'h00f707b3;
			RAM[373] =32'h0ff7f713;
			RAM[374] =32'hfdc42783;
			RAM[375] =32'h00078863;
			RAM[376] =32'hfdc42783;
			RAM[377] =32'hfff78793;
			RAM[378] =32'h0080006f;
			RAM[379] =32'h01d00793;
			RAM[380] =32'hff078793;
			RAM[381] =32'h008787b3;
			RAM[382] =32'hf687c783;
			RAM[383] =32'h00f707b3;
			RAM[384] =32'h0ff7f713;
			RAM[385] =32'hfdc42783;
			RAM[386] =32'hff078793;
			RAM[387] =32'h008787b3;
			RAM[388] =32'hf687c783;
			RAM[389] =32'h00f707b3;
			RAM[390] =32'h0ff7f713;
			RAM[391] =32'hfdc42683;
			RAM[392] =32'h01d00793;
			RAM[393] =32'h00f68863;
			RAM[394] =32'hfdc42783;
			RAM[395] =32'h00178793;
			RAM[396] =32'h0080006f;
			RAM[397] =32'h00000793;
			RAM[398] =32'hff078793;
			RAM[399] =32'h008787b3;
			RAM[400] =32'hf687c783;
			RAM[401] =32'h00f707b3;
			RAM[402] =32'h0ff7f493;
			RAM[403] =32'hfdc42783;
			RAM[404] =32'h36678793;
			RAM[405] =32'h00000737;
			RAM[406] =32'h00070713;
			RAM[407] =32'h00f707b3;
			RAM[408] =32'h0007c783;
			RAM[409] =32'h00f4e7b3;
			RAM[410] =32'h0ff7f793;
			RAM[411] =32'hffd78793;
			RAM[412] =32'h0017b793;
			RAM[413] =32'h0ff7f793;
			RAM[414] =32'h00f00733;
			RAM[415] =32'hfdc42783;
			RAM[416] =32'hff078793;
			RAM[417] =32'h008787b3;
			RAM[418] =32'hfae78423;
			RAM[419] =32'hfdc42783;
			RAM[420] =32'h00178793;
			RAM[421] =32'hfcf42e23;
			RAM[422] =32'hfdc42703;
			RAM[423] =32'h01d00793;
			RAM[424] =32'he6e7d4e3;
			RAM[425] =32'hfc042c23;
			RAM[426] =32'h0600006f;
			RAM[427] =32'hfd842783;
			RAM[428] =32'h34878793;
			RAM[429] =32'hfd842703;
			RAM[430] =32'hff070713;
			RAM[431] =32'h00870733;
			RAM[432] =32'hfc874703;
			RAM[433] =32'h000006b7;
			RAM[434] =32'h00068693;
			RAM[435] =32'h00f687b3;
			RAM[436] =32'h00e78023;
			RAM[437] =32'hfd842783;
			RAM[438] =32'h36678793;
			RAM[439] =32'hfd842703;
			RAM[440] =32'hff070713;
			RAM[441] =32'h00870733;
			RAM[442] =32'hfa874703;
			RAM[443] =32'h000006b7;
			RAM[444] =32'h00068693;
			RAM[445] =32'h00f687b3;
			RAM[446] =32'h00e78023;
			RAM[447] =32'hfd842783;
			RAM[448] =32'h00178793;
			RAM[449] =32'hfcf42c23;
			RAM[450] =32'hfd842703;
			RAM[451] =32'h01d00793;
			RAM[452] =32'hf8e7dee3;
			RAM[453] =32'h00000013;
			RAM[454] =32'h00000013;
			RAM[455] =32'h0ac12403;
			RAM[456] =32'h0a812483;
			RAM[457] =32'h0b010113;
			RAM[458] =32'h00008067;
			RAM[459] =32'hfd010113;
			RAM[460] =32'h02812623;
			RAM[461] =32'h03010413;
			RAM[462] =32'hfca42e23;
			RAM[463] =32'hfdc42783;
			RAM[464] =32'h0107d713;
			RAM[465] =32'hfdc42783;
			RAM[466] =32'h00e7d793;
			RAM[467] =32'h00f74733;
			RAM[468] =32'hfdc42783;
			RAM[469] =32'h00d7d793;
			RAM[470] =32'h00f74733;
			RAM[471] =32'hfdc42783;
			RAM[472] =32'h00b7d793;
			RAM[473] =32'h00f747b3;
			RAM[474] =32'h0017f793;
			RAM[475] =32'hfef42623;
			RAM[476] =32'hfdc42783;
			RAM[477] =32'h00179713;
			RAM[478] =32'hfec42783;
			RAM[479] =32'h00f767b3;
			RAM[480] =32'h00f00533;
			RAM[481] =32'h02c12403;
			RAM[482] =32'h03010113;
			RAM[483] =32'h00008067;

  end

  assign instr = RAM[pc[31:2]]; // word aligned
endmodule