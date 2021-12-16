module mips_cpu_sb(
    input logic[5:0] insop,
    input logic[31:0] mem_data,
    input logic[31:0] reg_data,
    output logic[31:0] out
);
    always @(*) begin
        case (insop)
            6'b101000: out={reg_data[7:0],mem_data[23:0]};
            6'b101001: out={reg_data[7:0],reg_data[15:8],mem_data[15:0]};
            6'b101011: out={reg_data[7:0],reg_data[15:8],reg_data[23:16],reg_data[31:24]};
        endcase
    end
	
endmodule