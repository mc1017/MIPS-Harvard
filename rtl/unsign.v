module unsign(
	input logic[31:0] instruction, 
	output logic unsign
	); 
	
	always @(*) begin 
		if((instruction[31:26] == 0) && ((instruction[5:0] == 6'b011001) || (instruction[5:0] == 6'b011011))) begin 
			unsign = 0; 
		end else begin 
			unsign = 1; 
		end 
	end 
	
	
endmodule 