module mips_cpu_hilo(
	input logic[31:0] hi_in, 
	input logic[31:0] lo_in, 
	input logic[31:0] reg_read_a, 
	input logic[5:0] insop, 
	input logic[5:0] func, 
	output logic[31:0] hi_out, 
	output logic[31:0] lo_out 
	);
	
	logic[31:0] hi, lo; 
	
	always_comb begin 
		if(insop == 6'b000000) begin 
			case(func) 
			6'b011010: begin 
				hi = hi_in; 
				lo = lo_in; 
			end 
			6'b011011: begin 
				hi = hi_in; 
				lo = lo_in; 
			end 
			6'b010001: hi = reg_read_a; 
			6'b010011: lo = reg_read_a; 
			6'b011000: begin 
				hi = hi_in; 
				lo = lo_in; 
			end 
			6'b011001: begin 
				hi = hi_in; 
				lo = lo_in; 
			end 
			endcase 
		end 
		hi_out = hi; 
		lo_out = lo; 
	end 
endmodule 