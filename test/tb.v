module tb(
	);
	
	logic clk, reset, active, clk_enable, data_write, data_read; 
	logic[31:0] instr_address, instr_readdata, data_address, data_writedata, data_readdate, register_v0; 
	
	initial begin 
		$dumpfile("tb.vcd"); 
		$dumpvars(0, tb); 
		reset = 0; 
		clk_enable = 1; 
		clk = 1; 
		repeat(60) begin 
			#4; 
			clk = !clk; 
		end 
	end 
	
	always_comb begin 
		if(instr_address == 32'd0) begin 
			instr_readdata = 32'b00100100001001000000000000100000; 
		end 
		if(instr_address == 32'd4) begin 
			instr_readdata = 32'b00100100001000110000000000000010; 
		end 
		if(instr_address == 32'd8) begin 
			instr_readdata = 32'b00100100001000100000000000000001; 
		end 
		if(instr_address == 32'd12) begin 
			instr_readdata = 32'b00010100001001000000000000000100; 
		end 
		if(instr_address == 32'd16) begin 
			instr_readdata = 32'b00001000000000000000000000011100; 
		end 
	end 
	
	mips_cpu_harvard dut(clk, reset, active, register_v0, clk_enable, instr_address, instr_readdata, data_address, data_write, data_read, data_writedata, data_readdate);
	
endmodule 