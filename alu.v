module alu(
  input logic[31:0] reg_read_a,
  input logic[31:0] alub,
  input logic[3:0] ALUcon,
  input logic sign,
  output logic eq,
  output logic lt,
  output logic[31:0] ALUoutput,
  output logic[31:0] lo,
  output logic[31:0] hi 
);

logic[63:0] multiplier;
typedef enum logic[3:0]{
    OPCODE_ADD = 4'd0,
    OPCODE_SUB = 4'd1,
    OPCODE_AND = 4'd2,
    OPCODE_OR = 4'd3,
    OPCODE_SLT = 4'd4,
    OPCODE_DIV = 4'd5,
    OPCODE_MULT = 4'd6,
    OPCODE_SLL = 4'd7,
    OPCODE_XOR = 4'd8
} opcode_t;

    always @(*)  begin
        if (ALUcon == OPCODE_ADD) begin
            ALUoutput= reg_read_a + alub;
        end
        else if (ALUcon == OPCODE_SUB) begin
            ALUoutput = reg_read_a - alub;
        end
        else if (ALUcon == OPCODE_AND) begin
            ALUoutput = reg_read_a & alub;
        end
        else if (ALUcon== OPCODE_OR) begin
            ALUoutput = reg_read_a | alub;
        end
        else if (ALUcon == OPCODE_SLT) begin
            if (reg_read_a<alub) begin
                ALUoutput = 32'd 1;
            end
            else begin
                ALUoutput = 32'd 0;
            end 
        end
        else if (ALUcon == OPCODE_DIV) begin
            hi = reg_read_a % alub;
            lo = reg_read_a/alub;
        end
        else if (ALUcon == OPCODE_MULT) begin
            multiplier = reg_read_a *alub;
            hi = multiplier[63:32];
            lo = multiplier[31:0];
        end
        else if (ALUcon == OPCODE_SLL) begin
            ALUoutput = reg_read_a << alub;
        end
        else if (ALUcon == OPCODE_XOR) begin
            ALUoutput = reg_read_a ^ alub;
        end
    end
    
endmodule