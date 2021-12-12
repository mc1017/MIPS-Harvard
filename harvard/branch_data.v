module branch_data (
	input logic[5:0] insop, 
	input logic[31:0] imm, 
	output logic[31:0] alub
	); 
	
	always @(*) begin 
		if ((insop == 6'b000001) || (insop == 6'b000111) || (insop == 6'b000110)) begin 
			alub = 32'b0; 
		end else begin 
			alub = imm; 
		end 
	end 
	
endmodule 