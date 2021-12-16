module mips_cpu_load(
    input logic[31:0] instruction,
    input logic[31:0] read_data,
    output logic[31:0] reg_data
);
    logic[31:0] out;
    //seperate instructions
    always @(*) begin
        case (instruction[31:26])
            6'b100000: out={(read_data[31])? 24'hffffff:24'd0 ,read_data[31:24]}; //LB load byte          
            6'b100100: out={24'b0, read_data[31:24]};//LBU load byte unsigned
            6'b100001: out={(read_data[31])? 16'hffff:16'd0,read_data[23:16],read_data[31:24]}; //LH load half-word
            6'b100101: out={16'd0,read_data[23:16],read_data[31:24]};
            6'b001111: out={instruction[15:0],16'd0};
            6'b100011: out={read_data[7:0],read_data[15:8],read_data[23:16],read_data[31:24]};
            default: out=read_data;
        endcase
        reg_data=out;
    end
endmodule