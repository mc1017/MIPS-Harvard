module mips_cpu_link (
	input logic[4:0] reg_write_addr_in, 
	input logic[31:0] instruction, 
	input logic[31:0] old_reg_data, 
	input logic[31:0] new_reg_data, 
	output logic[4:0] reg_write_addr_out, 
	output logic[31:0] new_reg_write_data
	); 
	
	logic link; 
	
	always @(*) begin 
		if ((instruction[31:26] == 6'b000011) || ((instruction[31:26] == 6'b000001) && ((instruction[20:16] == 5'b10001) || (instruction[20:16] == 5'b10000)))) begin
			reg_write_addr_out = 5'd31; 
		end 
		else begin 
			reg_write_addr_out = reg_write_addr_in; 
		end 
		if (((instruction[31:26] == 6'b000000) && (instruction[5:0] == 6'b001001)) || (instruction[31:26] == 6'b000011) || ((instruction[31:26] == 6'b000001) && ((instruction[20:16] == 5'b10001) || (instruction[20:16] == 5'b10000)))) begin
			new_reg_write_data = new_reg_data; 
		end 
		else begin 
			new_reg_write_data = old_reg_data; 
		end
		
	end 
	
	
endmodule 