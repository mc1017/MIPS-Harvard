module jr4;
	
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
			instr_readdata = 32'b00100100010000100000000000000001; 
		end 
		if(instr_address == 32'hBFC00004) begin 
			instr_readdata = 32'b00000000000000000000000000001000; 
		end
        if(instr_address == 32'hBFC00008) begin 
			instr_readdata = 32'b00100100010000100000000000000001; 
		end
        if(instr_address == 32'hBFC0000C) begin 
			instr_readdata = 32'b00100100000000000000000000000001; 
		end
	end
	always @(negedge clk) begin
		if (instr_address==0 && active==0) begin
			$display("CPU : OUT :%d", register_v0);
			$display("TB : Finished : active=0");
			$finish;
		end
		
	end
	
    logic[31:0] instr_readdata_be; 
	assign instr_readdata_be = {instr_readdata[7:0], instr_readdata[15:8], instr_readdata[23:16], instr_readdata[31:24]}; 
    
	
	mips_cpu_harvard dut(clk, reset, active, register_v0, clk_enable, instr_address, instr_readdata_be, data_address, data_write, data_read, data_writedata, data_readdata);
	mips_cpu_data_memory dm(clk, clk_enable, data_address, data_writedata, data_write, data_read, reset, data_readdata);
	
endmodule