module data_memory (
    input clk,
    input clock_enable,
    input logic [31:0] address,
    input logic [31:0] write_data,
    input logic write,
    input logic read,
    input logic reset,
    output [31:0] read_data
);
    reg [7:0] data_memory [4095:0];
    always_comb begin
        if (read==1) begin
            read[7:0]=data_memory[address+3];
            read[15:8]=data_memory[address+2];
            read[23:16]=data_memory[address+1];
            read[31:24]=data_memory[address];
        end
    end
    always @(posedge clk) begin
        if (!reset && clock_enable && write) begin
            data_memory[address+3]=write_data[7:0];
            data_memory[address+2]=write_data[15:8];
            data_memory[address+1]=write_data[23:16];
            data_memory[address]=write_data[31:24];
        end
    end
	
endmodule 