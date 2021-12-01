module unsign(
	input logic[31:0] instrucion, 
	output logic unsign
	); 
	
	always_comb begin 
		if((instrucion[31:26] == 0) && ((instruction[5:0] == 6'b011001) || (instrucion[5:0] == 6'b011011))) begin 
			unsign = 1; 
		end else begin 
			unsign = 0; 
		end 
	end 
	
	
endmodule 