module unsign(
	input logic[31:0] instruction, 
	output logic unsign
	); 
	
	always @(*) begin 
		if(((instruction[31:26] == 0) && ((instruction[5:0] == 6'b011001) || (instruction[5:0] == 6'b011011))) ||
			((instruction[31:26] == 6'b000001) || (instruction[31:26] == 6'b000111) || (instruction[31:26] == 6'b000110))) begin 
			unsign = 0; 
		end else begin 
			unsign = 1; 
		end 
	end 
	
	
endmodule 