module bltz2;
	
	logic clk, reset, active, clk_enable, data_write, data_read; 
	logic[31:0] instr_address, instr_readdata, data_address, data_writedata, data_readdata, register_v0; 
	
	initial begin 
		reset = 0; 
		clk_enable = 1; 
		clk = 1; 
		#4;
		repeat(100) begin 
			clk = !clk;
			#4;  
		end
	end 
	
	always @(*) begin 
		if(instr_address == 32'hBFC00000) begin 
			instr_readdata = 32'b00100100000000010000000000100000; 
		end 
		if(instr_address == 32'hBFC00004) begin 
			instr_readdata = 32'b00000000000000010001100000100011; 
		end
        if(instr_address == 32'hBFC00008) begin 
			instr_readdata = 32'b00000100001000000000000000000011; 
		end
        if(instr_address == 32'hBFC0000C) begin 
			instr_readdata = 32'b00100100000000100000000000100000; 
		end
        if(instr_address == 32'hBFC00010) begin 
			instr_readdata = 32'b00000100011000000000000000000010; 
		end
        if(instr_address == 32'hBFC00014) begin 
			instr_readdata = 32'b00100100010000100000000000100000; 
		end
        if(instr_address == 32'hBFC00018) begin 
			instr_readdata = 32'b00100100000000100000000000000001; 
        end
		if(instr_address == 32'hBFC0001C) begin 
			instr_readdata = 32'b00000100000000000000000000000010; 
		end
        if(instr_address == 32'hBFC00020) begin 
			instr_readdata = 32'b00100100010000100000000000100000; 
		end
        if(instr_address == 32'hBFC00024) begin 
			instr_readdata = 32'b00100100000000100000000000000001; 
		end
        if(instr_address == 32'hBFC00028) begin 
			instr_readdata = 32'b00100100010000100000000000100000; 
        end
		if(instr_address == 32'hBFC0002C) begin 
			instr_readdata = 32'b00000000000000000000000000001000; 
		end
        if(instr_address == 32'hBFC00030) begin 
			instr_readdata = 32'b00100100000000000000000000000000; 
		end
	end
	always @(negedge clk) begin
		if (instr_address==0) begin
			assert(register_v0 ==129);
			else $fatal(1,"Wrong Output");
		end
		
	end
	
    
	
	mips_cpu_harvard dut(clk, reset, active, register_v0, clk_enable, instr_address, instr_readdata, data_address, data_write, data_read, data_writedata, data_readdata);
	data_memory dm(clk, clk_enable, data_address, data_writedata, data_write, data_read, reset, data_readdata);
	
endmodule 