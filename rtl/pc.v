module pc(
	input logic clk, 
	input logic clk_enable, 
	input logic[31:0] pc_in, 
	output logic[31:0] pc_out
	); 
	
	reg[31:0] pcreg; 
	
	initial begin 
		pc_out = 32'hBFC00000-4; 
	end 
	
	always_ff @(posedge clk) begin 
		if (clk_enable == 1) begin 
			pc_out <= pc_in; 
		end 
	end 


endmodule 