module mips_cpu_data_memory (
    input logic clk,
    input logic clock_enable,
    input logic [31:0] address,
    input logic [31:0] write_data,
    input logic write,
    input logic read,
    input logic reset,
    output logic[31:0] read_data
);
    reg [7:0] data_memory [4095:0];
    logic [31:0] c;
    initial begin
        c=0;
        repeat (4096) begin
            data_memory[c]=0;
            c+=1;
        end
		data_memory[0] = 8'b10001001; 
		data_memory[1] = 8'b10101011; 
		data_memory[2] = 8'b11001101; 
		data_memory[3] = 8'b11101111; 
		data_memory[4] = 8'b01010101; 
		data_memory[5] = 8'b01010101; 
		data_memory[6] = 8'b01010101; 
		data_memory[7] = 8'b01010101; 
		data_memory[8] = 8'b00000001; 
		data_memory[9] = 8'b00000001; 
		data_memory[10] = 8'b00000001; 
		data_memory[11] = 8'b00000001; 
		data_memory[12] = 8'b11001100; 
		data_memory[13] = 8'b11001100; 
		data_memory[14] = 8'b11001100; 
		data_memory[15] = 8'b11001100; 
    end
    always_comb begin
        if (read==1) begin
            read_data[7:0]=data_memory[address+3];
            read_data[15:8]=data_memory[address+2];
            read_data[23:16]=data_memory[address+1];
            read_data[31:24]=data_memory[address];
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