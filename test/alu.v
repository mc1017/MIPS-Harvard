module alu(
  input logic[31:0] reg_read_a,
  input logic[31:0] alub,
  input logic[3:0] ALUcon,
  input logic unsign,
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
    OPCODE_XOR = 4'd8,
    OPCODE_SRA = 4'd9,
    OPCODE_SRL = 4'd10
} opcode_t;

    always @(*)  begin
        if (ALUcon == OPCODE_ADD) begin
            if (unsign ==0) begin
                ALUoutput= reg_read_a + alub;
            end
            else begin
                ALUoutput= $unsigned(reg_read_a) + $unsigned(alub);
            end

        end
        else if (ALUcon == OPCODE_SUB) begin
            if (unsign==0) begin
                ALUoutput = $signed(reg_read_a) - $signed(alub);
                if (($signed(reg_read_a)-$signed(alub))==0) begin
                    eq=1;
                end
                else if (($signed(reg_read_a)-$signed(alub))<0) begin
                    lt=1;
                end
                else begin
                    lt=0;
                end
                
            end
            else if (unsign==1) begin
                ALUoutput = $unsigned(reg_read_a) - $unsigned(alub);
                if (($unsigned(reg_read_a)-$unsigned(alub))==0) begin
                    eq=1;
                end
                else if (($unsigned(reg_read_a)-$unsigned(alub))<0) begin
                    $display("%d", $unsigned(reg_read_a)-$unsigned(alub));
                    lt=1;
                end
                else begin
                    lt=0;
                end
            end
        end
        else if (ALUcon == OPCODE_AND) begin
            ALUoutput = reg_read_a & alub;
        end
        else if (ALUcon== OPCODE_OR) begin
            ALUoutput = reg_read_a | alub;
        end
        else if (ALUcon == OPCODE_SLT) begin
            if (unsign ==0) begin
                if (reg_read_a<alub) begin
                    ALUoutput = 32'd 1;
                end
                else begin
                    ALUoutput = 32'd 0;
                end     
            end
            else if (unsign==1) begin
                if ($unsigned(reg_read_a)<$unsigned(alub)) begin
                    ALUoutput = 32'd 1;
                end
                else begin
                    ALUoutput = 32'd 0;
                end 
            end
            
        end
        else if (ALUcon == OPCODE_DIV) begin
            if (unsign ==0) begin
                hi = $signed(reg_read_a) % $signed(alub);
                lo = $signed(reg_read_a)/$signed(alub);
            end
            else if (unsign ==1) begin
                hi = $unsigned(reg_read_a) % $unsigned(alub);
                lo = $unsigned(reg_read_a)/$unsigned(alub);
            end
            
        end
        else if (ALUcon == OPCODE_MULT) begin
            if (unsign ==0) begin
                multiplier = $signed(reg_read_a) *$signed(alub);
                hi = multiplier[63:32];
                lo = multiplier[31:0];
                 
            end
            else if (unsign ==1) begin
                multiplier = $unsigned(reg_read_a) *$unsigned(alub);
                hi = multiplier[63:32];
                lo = multiplier[31:0];
            end
            
        end
        else if (ALUcon == OPCODE_SLL) begin
            ALUoutput = reg_read_a << alub;
        end
        else if (ALUcon == OPCODE_XOR) begin
            ALUoutput = reg_read_a ^ alub;
        end
        else if (ALUcon == OPCODE_SRA) begin
            ALUoutput = reg_read_a>>>alub;
        end
        else if (ALUcon == OPCODE_SRL) begin
            ALUoutput = reg_read_a >>alub;
        end
    end
    
endmodule