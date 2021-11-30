module alu_tb();
    logic[31:0] reg_read_a;
    logic[31:0] alub;
    logic[3:0] ALUcon;
    logic sign;
    logic eq;
    logic lt;
    logic[31:0] ALUoutput;
    logic[31:0] lo;
    logic[31:0] hi; 

    alu dut(
        .reg_read_a(reg_read_a),
        .alub(alub), 
        .ALUcon(ALUcon), 
        .sign(sign),
        .eq(eq), 
        .lt(lt), 
        .ALUoutput(ALUoutput), 
        .lo(lo),
        .hi(hi)
    );

//Without Loop
    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0,alu_tb);
        #1;
        reg_read_a = 34;
        alub = 10;
        ALUcon = 0;
        #1
        assert(ALUoutput==44);
        ALUcon = 1;
        #1;
        assert(ALUoutput==24);
        ALUcon = 2;
        #1
        assert(ALUoutput ==2 );
        ALUcon = 3;
        #1
        assert(ALUoutput== 42);
        ALUcon = 4;
        #1
        assert (ALUoutput == 0);
        ALUcon = 5;
        #1
        assert(hi==4);
        assert(lo== 3);
        ALUcon = 6;
        #1
        assert(hi==0)
        assert(lo == 340);
        ALUcon = 7;
        #1
        assert(ALUoutput == 34816);
        ALUcon = 8;
        #1
        assert(ALUoutput == 40);
        $display("Passed testcase a =34, b=10");
        #1;
        reg_read_a = 10;
        alub = 34;
        ALUcon = 0;
        #1
        assert(ALUoutput==44);
        ALUcon = 1;
        #1;
        assert(ALUoutput==-24);
        ALUcon = 2;
        #1
        assert(ALUoutput ==2 );
        ALUcon = 3;
        #1
        assert(ALUoutput== 42);
        ALUcon = 4;
        #1
        assert (ALUoutput == 1);
        ALUcon = 5;
        #1
        assert(hi==10);
        assert(lo== 0);
        ALUcon = 6;
        #1
        assert(hi==0)
        assert(lo == 340);
        ALUcon = 7;
        #1
        assert(ALUoutput == 0);
        ALUcon = 8;
        #1
        assert(ALUoutput == 40);
        $display("Passed testcase a =10, b=34");
        $finish(0);
    end
endmodule