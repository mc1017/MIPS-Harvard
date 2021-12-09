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
	
	logic[31:0] instruction, a, b, reg_write_data, reg_read_a, reg_read_b, alub1, imm, aluout, hi, lo, target, pc4, pc_in, pc_out, link_data, reg_write_data_1, reg_write_data_2, reg_write_data_3, mem_addr_hold, alub_in, alua_in, sa; 
	logic[1:0] alucwire; 
	logic[3:0] alucon; 
	logic[4:0] addrs, addrt, addrd, reg_write_addr, reg_write_addr_hold; 
	logic[5:0] insop, func; 
	logic branch, jump, eq, lt, regdst, alusrc, memtoreg, regwrite, unsign; 
	
	assign imm = {{16{instruction[15]}} , instruction[15:0]}; //sign extend immediate
	
	assign target = {pc_out[31:28] , instruction[25:0] , 2'b00}; //acquire target 
	
	assign sa = {27'b0 , instruction[10:6]}; //acquire sa
	
	assign pc4 = pc_out + 4; 
	
	assign instr_address = pc_out; 
	
	assign instruction = instr_readdata; 
	
	initial begin
		active=0;
	end
	always @(posedge clk) begin//active reset
		if (reset) begin
			active=1;
		end
		if (instr_address==0) begin
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
		data_writedata = reg_read_b; 
	end 
	
	register_file regfile(clk, clk_enable, reset, addrs, addrt, reg_write_data, reg_write_addr, regwrite, reg_read_a, reg_read_b); 
	control control_block(insop,addrt, func, regdst, jump, branch, data_read, memtoreg, alucwire, data_write, alusrc, regwrite); 
	alu alu_block(alua_in, alub_in, alucon, unsign, eq, lt, aluout, lo, hi); 
	alucontrol alucontrol_block(func, insop, alucwire, alucon); 
	pc_update pcupdate_block(reset, branch, jump, eq, lt, instruction, reg_read_a, imm, target, pc4, pc_in, link_data); 
	pc pc_block(clk, clk_enable, pc_in, pc_out); 
	load load_block(instruction, reg_write_data_1, reg_write_data_2); 
	data_address_control dac_block(mem_addr_hold, instruction, data_address); 
	link link_block(reg_write_addr_hold, instruction, reg_write_data_3, link_data, reg_write_addr, reg_write_data); 
	lw lw_block(instruction, data_address, reg_write_data_2, reg_read_b, reg_write_data_3); 
	hilo hilo_block(hi, lo, reg_read_a, insop, func); 
	unsign unsign_block(instruction, unsign); 
	branch_data branch_data_block(insop, imm, alub1); 
	shift_control shift_control_block(instruction, reg_read_a, sa, alua_in); 
	
	
endmodule 