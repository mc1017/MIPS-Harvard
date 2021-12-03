module instruction_memory(
    input logic[31:0] address,
    output logic[31:0] instruction
);

    reg [31:0] memory [1000:0];
    initial begin
        logic[31:0] i;
        i=0;
        repeat (100) begin
            memory[i]=i;
            i=i+1;
        end
    end
    always_comb begin
        instruction=memory[address];
    end

endmodule
