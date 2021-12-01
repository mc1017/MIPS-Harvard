module alucontrol (
	input logic[5:0] func, 
	input logic[5:0] op, 
	input logic[1:0] ALUop, 
	output logic[3:0] ALUcon
	); 
	
	always_comb begin 
		case(ALUop) 
		0: begin 
			case(func)
			6'b100100: ALUcon = 4'b0010; 
			6'b011010: ALUcon = 4'b0101; 
			6'b011011: ALUcon = 4'b0101; 
			6'b011000: ALUcon = 4'b0110; 
			6'b011001: ALUcon = 4'b0110; 
			6'b100101: ALUcon = 4'b0011; 
			6'b000000: ALUcon = 4'b0111; 
			6'b000100: ALUcon = 4'b0111; 
			6'b101010: ALUcon = 4'b0100; 
			6'b101011: ALUcon = 4'b0100; 
			6'b000011: ALUcon = 4'b1001; 
			6'b000111: ALUcon = 4'b1001; 
			6'b000010: ALUcon = 4'b1010; 
			6'b000110: ALUcon = 4'b1010; 
			6'b100011: ALUcon = 4'b0001; 
			6'b100110: ALUcon = 4'b1000; 
			endcase
		end 
		1: ALUcon = 4'b0001; 
		2: ALUcon = 4'b0100;
		3: begin
			case(op) 
			6'b001100: ALUcon = 4'b0010; 
			6'b001101: ALUcon = 4'b0011; 
			6'b001110: ALUcon = 4'b1000; 
			endcase
		end 
		default: ALUcon = 4'b0000; 
		endcase 
	end 
	
endmodule 