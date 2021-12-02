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
		if(instr_address == 32'd4) begin 
			instr_readdata = 32'b00100100001000110000000000000101; 
		end 
		if(instr_address == 32'd8) begin 
			instr_readdata = 32'b00100100011000010000000000000110; 
		end 
		if(instr_address == 32'd12) begin 
			instr_readdata = 32'b00000000011000010101100000100001; 
		end 
		if(instr_address == 32'd16) begin 
			instr_readdata = 32'b00000000001000110001000000100100; 
		end 
		if(instr_address == 32'd20) begin 
			instr_readdata = 32'b00110000001000100000000000011111; 
		end 
		if(instr_address == 32'd24) begin 
			instr_readdata = 32'b00001000000000000000000000100000; 
		end 
		if(instr_address == 32'd28) begin 
			instr_readdata = 32'b00100101011001000000000000000001; 
		end 
		if(instr_address == 32'd32) begin 
			instr_readdata = 32'b00100101011001010000000000000010; 
		end 
		if(instr_address == 32'd36) begin 
			instr_readdata = 32'b00101100011010000000000000001000; 
		end 
		if(instr_address == 32'd40) begin 
			instr_readdata = 32'b00000000001001010100100000100101; 
		end 
		if(instr_address == 32'd44) begin 
			instr_readdata = 32'b00110100010010010000000000001111; 
		end 
		if(instr_address == 32'd48) begin 
			instr_readdata = 32'b00000000001001010101000000100110; 
		end 
		if(instr_address == 32'd52) begin 
			instr_readdata = 32'b00000000001001010101000000100110; 
		end 
	end 
	
	mips_cpu_harvard dut(clk, reset, active, register_v0, clk_enable, instr_address, instr_readdata, data_address, data_write, data_read, data_writedata, data_readdate);
	
endmodule 