module sb(
    input logic[5:0] insop,
    input logic[31:0] mem_data,
    input logic[31:0] reg_data,
    output logic[31:0] out
);
    always @(*) begin
        case (insop)
            6'b101000: out={mem_data[31:8],reg_data[7:0]};
            6'b101001: out={mem_data[31:16],reg_data[15:0]};
        endcase
    end
	
endmodule