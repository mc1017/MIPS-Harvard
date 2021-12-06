module instruction_memory(
    input logic[31:0] address,
    output logic[31:0] instruction
);

    reg [7:0] memory [4095:0];
	
    initial begin
        logic[31:0] i;
        i=0;
        repeat (4096) begin
            memory[i]=0;
            i=i+1;
        end
    end
    always_comb begin
        instruction={memory[address],memory[address+1],memory[address+2],memory[address+3]};
    end

endmodule
