module data_address_control(
    input logic[31:0] address,
    input logic[31:0] instruction,
    output logic[31:0] address_out
);

    always @(*) begin
        if (instruction[31:26] == 6'b100110) begin
            address_out = address - address % 4;
        end 
		else begin 
            address_out = address;
        end
    end


endmodule