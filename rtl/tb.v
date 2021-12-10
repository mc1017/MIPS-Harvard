module tb(
	);
	
	logic clk, reset, active, clk_enable, data_write, data_read; 
	logic[31:0] instr_address, instr_readdata, data_address, data_writedata, data_readdata, register_v0; 
	
	initial begin 
		$dumpfile("tb.vcd"); 
		$dumpvars(0, tb); 
		reset = 0; 
		clk_enable = 1; 
		clk = 0; 
		repeat(100) begin 
			#4; 
			clk = !clk; 
		end 
	end 
	
	always_comb begin 
		if(instr_address == 0) begin 
			instr_readdata = 32'b00100100000000010000000000100000; 
		end 
		if(instr_address == 4) begin 
			instr_readdata = 32'b00010000001000000000000000000011; 
		end 
		if(instr_address == 8) begin 
			instr_readdata = 32'b00100100000000100000000000100000; 
		end 
		if(instr_address == 12) begin 
			instr_readdata = 32'b00010000001000100000000000000010; 
		end 
		if(instr_address == 16) begin 
			instr_readdata = 32'b00100100010000100000000000100000; 
		end 
		if(instr_address == 20) begin 
			instr_readdata = 32'b00100100000000100000000000000001; 
		end 
		if(instr_address == 24) begin 
			instr_readdata = 32'b00100100010000100000000000100000; 
		end 
		if(instr_address == 28) begin 
			instr_readdata = 32'b00000011111000000000000000001000 ; 
		end
		if(instr_address == 32) begin 
			instr_readdata = 0 ; 
		end
		
	end 
	
	mips_cpu_harvard dut(clk, reset, active, register_v0, clk_enable, instr_address, instr_readdata, data_address, data_write, data_read, data_writedata, data_readdata);
	data_memory dm(clk, clk_enable, data_address, data_writedata, data_write, data_read, reset, data_readdata);
	
endmodule 