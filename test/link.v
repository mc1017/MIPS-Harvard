module link (
	input logic[4:0] reg_write_addr_in, 
	input logic[31:0] instruction, 
	output logic[4:0] reg_write_addr_out
	); 
	
	always @(*) begin 
		if ((instruction[31:26] == 6'b000011) || ((instruction[31:26] == 6'b000001) && ((instruction[20:16] == 5'b10001) || (instruction[20:16] == 5'b10000)))) begin
			reg_write_addr_out = 5'd31; 
		end 
		else begin 
			reg_write_addr_out = reg_write_addr_in; 
		end 
	end 
	
	
endmodule 