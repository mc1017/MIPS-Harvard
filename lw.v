module lw(
    input logic[31:0] instruction,
    input logic[31:0] mem_address,
    input logic[31:0] read_data,
    input logic[31:0] reg_d,
    output logic[31:0] reg_data
);
    logic[31:0] c;
    logic[31:0] out;
    always @(*) begin
        case (instruction[31:26])
            6'b100010: //load word left
                case (mem_address%4)
                    0: out=read_data;
                    1:  out={read_data[23:0],reg_d[7:0]};
                    2:  out={read_data[15:0],reg_d[15:0]};
                    3:  out={read_data[7:0],reg_d[23:0]};
                endcase
            6'b100110: //the address for the data is changed to the closest position where add%4=0
                case (mem_address%4)
                    0:  out={reg_d[31:8],read_data[31:24]};
                    1:  out={reg_d[31:16],read_data[31:16]};
                    2:  out={reg_d[31:24],read_data[31:8]};
                    3:  out=read_data;
                endcase
            default: out=read_data;

        endcase
        reg_data=out;
    end
endmodule