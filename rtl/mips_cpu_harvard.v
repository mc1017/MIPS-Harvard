module mips_cpu_harvard(
    /* Standard signals */
    input logic     clk,
    input logic     reset,
    output logic    active,
    output logic [31:0] register_v0,

    /* New clock enable. See below. */
    input logic     clk_enable,

    /* Combinatorial read access to instructions */
    output logic[31:0]  instr_address, 
    input logic[31:0]   instr_readdata, 

    /* Combinatorial read and single-cycle write access to instructions */
    output logic[31:0]  data_address,
    output logic        data_write,
    output logic        data_read,
    output logic[31:0]  data_writedata,
    input logic[31:0]  data_readdata
);
	
	logic[31:0] instruction, a, b, reg_write_data, reg_read_a, reg_read_b, alub1, imm, aluout, hi_in, lo_in, hi_out, lo_out, target, pc4, pc_in, pc_out, link_data, reg_write_data_1, reg_write_data_2, reg_write_data_3, reg_write_data_4, mem_addr_hold, alub_in, alua_in, sa, r2, sb_reg_in, sb_mem_in, sb_out; 
	logic[1:0] alucwire; 
	logic[3:0] alucon; 
	logic[4:0] addrs, addrt, addrd, reg_write_addr, reg_write_addr_hold; 
	logic[5:0] insop, func; 
	logic branch, jump, eq, lt, regdst, alusrc, memtoreg, regwrite, unsign; 
	
	//zero-extend imm in case of ANDI/ORI/XORI, otw sign-extend 
	assign imm = ((insop == 001100) || (insop == 001101) || (insop == 001110)) ? {{16{instruction[15]}} , instruction[15:0]} : {{16'h0000} , instruction[15:0]}; 
	
	assign target = {pc_out[31:28] , instruction[25:0] , 2'b00}; //acquire target 
	
	assign sa = {27'b0 , instruction[10:6]}; //acquire sa 
	
	assign pc4 = pc_out + 4; 
	
	assign instr_address = pc_out; 
	
	assign instruction = {instr_readdata[7:0], instr_readdata[15:8], instr_readdata[23:16], instr_readdata[31:24]}; 
	
	assign sb_reg_in = reg_read_b; 
	
	assign sb_mem_in = data_readdata; 
	
	initial begin
		active=0;
	end
	
	always @(*) begin//active reset
		if (reset) begin
			active=1;
		end else if (instr_address==0) begin
			active=0; 
		end 
	end 
	
	always @(*) begin 
		addrs = instruction[25:21]; 
		addrt = instruction[20:16]; 
		addrd = instruction[15:11]; 
		insop = instruction[31:26]; 
		func = instruction[5:0]; 
		reg_write_addr_hold = (regdst == 0) ? addrt : addrd; 
		reg_write_data_1 = (memtoreg == 0) ? aluout : data_readdata; 
		alub_in = (alusrc == 0) ? reg_read_b : alub1; 
		mem_addr_hold = aluout; 
		data_writedata = ((insop == 6'b101001) || (insop == 6'b101000)) ? sb_out : reg_read_b; 
		reg_write_data = (insop == 6'b000000 && func == 6'b010000) ? hi_out : (insop == 6'b000000 && func == 6'b010010) ? lo_out : reg_write_data_4; 
		if (instr_address==0) begin
			register_v0 = r2;  
		end
	end 
	
	mips_cpu_register_file regfile(clk, clk_enable, reset, r2, addrs, addrt, reg_write_data, reg_write_addr, regwrite, reg_read_a, reg_read_b); 
	mips_cpu_control control_block(insop,addrt, func, regdst, jump, branch, data_read, memtoreg, alucwire, data_write, alusrc, regwrite); 
	mips_cpu_alu alu_block(alua_in, alub_in, alucon, unsign, eq, lt, aluout, lo_in, hi_in); 
	mips_cpu_alucontrol alucontrol_block(func, insop, alucwire, alucon); 
	mips_cpu_pc_update pcupdate_block(clk_enable,clk,reset, branch, jump, eq, lt, instruction, reg_read_a, imm, target, pc4, pc_out, link_data); 
	mips_cpu_load load_block(instruction, reg_write_data_1, reg_write_data_2); 
	mips_cpu_data_address_control dac_block(mem_addr_hold, instruction, data_address); 
	mips_cpu_link link_block(reg_write_addr_hold, instruction, reg_write_data_3, link_data, reg_write_addr, reg_write_data_4); 
	mips_cpu_lw lw_block(instruction, mem_addr_hold, reg_write_data_2, reg_read_b, reg_write_data_3); 
	mips_cpu_hilo hilo_block(hi_in, lo_in, reg_read_a, insop, func, hi_out, lo_out); 
	mips_cpu_unsign unsign_block(instruction, unsign); 
	mips_cpu_branch_data branch_data_block(insop, imm, alub1); 
	mips_cpu_shift_control shift_control_block(instruction, reg_read_a, sa, alua_in); 
	mips_cpu_sb sb_block(insop, sb_mem_in, sb_reg_in, sb_out); 
	
	
endmodule 