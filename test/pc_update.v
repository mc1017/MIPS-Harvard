module pc_update(
    input logic reset,
    input logic branch,
    input logic jump,
    input logic eq,
    input logic lt,
    input logic[31:0] instruction,
    input logic[31:0] reg_read,
    input logic[31:0] immediate, //need to shift 2
    input logic[31:0] target,
    input logic[31:0] pc4,
    output logic[31:0] pc_out,
    output logic[31:0] reg_out
);
    logic[31:0] out,shift;
    always @(*) begin
        if (reset) begin
            pc_out=32'hBFC00000;
        end 
		else if (branch) begin
			shift=immediate<<2;
			out=pc4+shift;
			case (instruction[31:26])
				6'b000100: begin // branch on equal 
					if (eq) begin
						pc_out=out;
					end else begin
						pc_out=pc4;
					end
				end
				6'b000001: begin 
					case (instruction[20:16])
						5'b00001: begin
							if (eq || !lt) begin
								pc_out=out;
							end
							else begin
								pc_out=pc4;
							end
						end
						5'b10001: begin
							if (eq || !lt) begin
								pc_out=out;
								reg_out=pc4+4;
							end
							else begin
								pc_out=pc4;
							end
						end
						5'b00000: begin
							if (lt) begin
								pc_out=out;
							end
							else begin
								pc_out=pc4;
							end
						end
						5'b10000: begin
							if (lt) begin
								pc_out=out;
								reg_out=pc4+4;
							end
							else begin
								pc_out=pc4;
							end
						end
					endcase
					
				end
				6'b000101: begin // branch on not equal
					if (!eq) begin
						pc_out=out;
					end else begin
						pc_out=pc4;
					end
				end 
				6'b000111: begin //branch on greater than zero
					if (!lt) begin
						pc_out=out;
					end else begin
						pc_out=pc4;
					end
				end
				6'b000110: begin //branch on less than or equal to zero
					if (eq || lt) begin
						pc_out=out;
					end else begin
						pc_out=pc4;
					end
				end
			endcase
		end else if (jump) begin
			case (instruction[31:26])
				6'b000010: pc_out=target; //jump
				6'b000011: begin  //jump and link
					pc_out=target;
					reg_out=pc4+4;
				end
				6'b000000: begin
					if (!instruction[0]) begin
						pc_out=reg_read;
					end
					else begin
						reg_out=pc4+4;
						pc_out=reg_read;
					end
				end 
			endcase
        end else begin
            pc_out=pc4;
        end
    end
	
	
endmodule