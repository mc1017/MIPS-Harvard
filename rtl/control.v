module control(
	input logic[5:0] insop, 
	input logic[4:0] branchfield, 
	input logic[5:0] func, 
	output logic regdst,
	output logic jump, 
	output logic branch, 
	output logic memread, 
	output logic memtoreg, 
	output logic[1:0] ALUop, 
	output logic memwrite, 
	output logic ALUsrc, 
	output logic regwrite 
	); 
	
	logic[9:0] controlsig; 
	
	assign regdst = controlsig[9]; 
	assign jump = controlsig[8]; 
	assign branch = controlsig[7]; 
	assign memread = controlsig[6]; 
	assign memwrite = controlsig[5]; 
	assign memtoreg = controlsig[4]; 
	assign regwrite = controlsig[3];
	assign ALUsrc = controlsig[2]; 
	assign ALUop = controlsig[1:0]; 
	
	always_comb begin
		case (insop) 
		6'b001001: controlsig = 10'b0000001111; 
		6'b000000: begin 
			case(func) 
			6'b100001: controlsig = 10'b1000001000; 
			6'b100100: controlsig = 10'b1000001000; 
			6'b011010: controlsig = 10'b0000000000; 
			6'b011011: controlsig = 10'b0000000000; 
			6'b001001: controlsig = 10'b1100001000; 
			6'b001000: controlsig = 10'b0100000000; 
			6'b010001: controlsig = 10'b0000000000; 
			6'b010011: controlsig = 10'b0000000000; 
			6'b011000: controlsig = 10'b0000000000; 
			6'b011001: controlsig = 10'b0000000000; 
			6'b100101: controlsig = 10'b1000001000; 
			6'b000000: controlsig = 10'b1000001000; 
			6'b000100: controlsig = 10'b1000001000; 
			6'b101010: controlsig = 10'b1000001000; 
			6'b101011: controlsig = 10'b1000001000; 
			6'b000011: controlsig = 10'b1000001000; 
			6'b000111: controlsig = 10'b1000001000; 
			6'b000010: controlsig = 10'b1000001000; 
			6'b000110: controlsig = 10'b1000001000; 
			6'b100011: controlsig = 10'b1000001000; 
			6'b100110: controlsig = 10'b1000001000; 
			endcase
		end
		6'b001100: controlsig = 10'b0000001111; 
		6'b000100: controlsig = 10'b0010000001; 
		6'b000001: begin 
			case(branchfield) 
			5'b00001: controlsig = 10'b0010000101; 
			5'b10001: controlsig = 10'b0010001101; 
			5'b00000: controlsig = 10'b0010000101; 
			5'b10000: controlsig = 10'b0010001101; 
			endcase
		end 
		6'b000111: controlsig = 10'b0010000101; 
		6'b000110: controlsig = 10'b0010000101; 
		6'b000101: controlsig = 10'b0010000001; 
		6'b000010: controlsig = 10'b0100000000; 
		6'b000011: controlsig = 10'b0100000000; 
		6'b100000: controlsig = 10'b0001011111; 
		6'b100100: controlsig = 10'b0001011111; 
		6'b100001: controlsig = 10'b0001011111; 
		6'b100101: controlsig = 10'b0001011111; 
		6'b001111: controlsig = 10'b0000001111; 
		6'b100011: controlsig = 10'b0001011111; 
		6'b100010: controlsig = 10'b0001011111; 
		6'b100110: controlsig = 10'b0001011111; 
		6'b001101: controlsig = 10'b0000001111; 
		6'b101000: controlsig = 10'b0000100111; 
		6'b101001: controlsig = 10'b0000100111; 
		6'b001010: controlsig = 10'b0000001110; 
		6'b001011: controlsig = 10'b0000001110; 
		6'b101011: controlsig = 10'b0000100111; 
		endcase 
	end
	
endmodule 