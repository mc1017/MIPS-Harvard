module mips_cpu_pc_update(
	input clk_enable,
	input clk,
    input logic reset,
    input logic branch,
    input logic jump,
    input logic eq,
    input logic lt,
    input logic[31:0] instruction,
    input logic[31:0] reg_read,
    input signed [31:0] immediate, //need to shift 2
    input logic[31:0] target,
    input logic[31:0] pc4,
    output logic[31:0] pc_out_d,
    output logic[31:0] reg_out
);
    logic signed[31:0] out;
	logic signed[31:0] shift,pc_out;
	logic branch_d,jump_d,fail;
	logic [31:0] pc_target;
	initial begin
		pc_out_d=32'hBFC00000-4;
	end
	
	always @(posedge clk) begin
		branch_d<=branch;
		jump_d<=jump;
		if (branch || jump) begin
			fail=0;
			pc_out_d<=pc4; 
			pc_target<=fail?(pc4+4):pc_out;
		end else begin
			pc_out=pc4;
			if (branch_d || jump_d) begin
				pc_out_d<=pc_target;
			end else begin
				pc_out_d<=pc_out;
			end
		end
		
		if (reset) begin
            pc_out_d<=32'hBFC00000;
        end 
	end
	
	
    always @(*) begin
        
		if (branch) begin
			shift=immediate<<2;
			out=pc4+shift;
			case (instruction[31:26])
				6'b000100: begin // branch on equal 
					if (eq) begin
						pc_out=out;
					end else begin
						pc_out=pc4+4;
						fail=1;
					end
				end
				6'b000001: begin 
					case (instruction[20:16])
						5'b00001: begin
							if (eq || !lt) begin
								pc_out=out;
							end
							else begin
								pc_out=pc4+4;
								fail=1;
							end
						end
						5'b10001: begin
							if (eq || !lt) begin
								pc_out=out;
								reg_out=pc4+4;
							end
							else begin
								pc_out=pc4+4;
								fail=1;
							end
						end
						5'b00000: begin
							if (lt) begin
								pc_out=out;
							end
							else begin
								pc_out=pc4+4;
								fail=1;
							end
						end
						5'b10000: begin
							if (lt) begin
								pc_out=out;
								reg_out=pc4+4;
							end
							else begin
								pc_out=pc4+4;
								fail=1;	
							end
						end
					endcase
					
				end
				6'b000101: begin // branch on not equal
					if (!eq) begin
						pc_out=out;
					end else begin
						pc_out=pc4+4;
						fail=1;
					end
				end 
				6'b000111: begin //branch on greater than zero
					if (!lt && !eq) begin
						pc_out=out;
					end else begin
						pc_out=pc4+4;
						fail=1;
					end
				end
				6'b000110: begin //branch on less than or equal to zero
					if (eq || lt) begin
						pc_out=out;
					end else begin
						pc_out=pc4+4;
						fail=1;
					end
				end
			endcase
			end 
			if (jump) begin
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
			
			end
    end
	
	
endmodule