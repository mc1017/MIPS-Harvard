module mips_cpu_pc(
	input logic clk, 
	input logic clk_enable, 
	input logic[31:0] pc_in, 
	output logic[31:0] pc_out
	); 
	
	reg[31:0] pcreg; 
	
	
	always @(*) begin 
		if (clk_enable == 1) begin 
			pc_out <= pc_in; 
		end 
	end 


endmodule 