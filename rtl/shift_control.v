module shift_control(
	input logic[31:0] instruction, 
	input logic[31:0] org_data, 
	input logic[31:0] sa, 
	output logic[31:0] alu_in
	); 
	
	always @(*) begin 
		if ((instruction[31:26] == 6'b0) && ((instruction[5:0] == 6'b000011) || (instruction[5:0] == 6'b000010) || (instruction[5:0] == 6'b0))) begin 
			alu_in = sa; 
		end else begin 
			alu_in = org_data; 
		end 
	end 
	
	
endmodule 