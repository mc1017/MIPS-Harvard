module register_file(
    input logic clk,
    input logic clk_enable,
    input logic reset,
    input logic[4:0] address_1,
    input logic[4:0] address_2,
    input logic[31:0] write_data,
    input logic[4:0] write_address,
    input logic write_enable,
    output logic[31:0] read_data1,
    output logic[31:0] read_data2
);
    reg [31:0] memory[15:0];
    logic[15:0] c;
	
    always @(posedge clk) begin 
        if (reset) begin
            c=0;
            repeat(65536) begin
                memory[c]=32'd0;
                c+=1;
            end
        end else if (clk_enable==1 && write_enable==1) begin
                memory[write_address]=write_data;
        end
    end
	
    always_comb begin
        read_data1=memory[address_1];
        read_data2=memory[address_2];
    end


endmodule