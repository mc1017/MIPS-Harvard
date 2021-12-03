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
	reg [31:0] memory[32:0];
    logic[31:0] d;
    logic[4:0] c;
    initial begin
        c=0;
        d=0;
        repeat (32) begin
            memory[c]=0;
            //d+=1;
            c+=1;
        end
    end
    always @(posedge clk) begin 
        if (reset) begin
            c=0;
            repeat(32) begin
                memory[c]=32'd0;
                c+=1;
            end
        end else begin
            if (clk_enable==1 && write_enable==1) begin
				if((address_1 != 0) && (address_2 != 0)) begin 
					memory[write_address]=write_data;
				end 
            end
        end
         
    end
    always_comb begin
        read_data1=memory[address_1];
        read_data2=memory[address_2];
    end
endmodule