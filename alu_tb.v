module alu_tb();
    logic[31:0] reg_read_a;
    logic[31:0] alub;
    logic[3:0] ALUcon;
    logic unsign;
    logic eq;
    logic lt;
    logic[31:0] ALUoutput;
    logic[31:0] lo;
    logic[31:0] hi; 

    alu dut(
        .reg_read_a(reg_read_a),
        .alub(alub), 
        .ALUcon(ALUcon), 
        .unsign(unsign),
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
        unsign=0;
        reg_read_a = 34;
        alub = 10;
        ALUcon = 0;
        #1;
        assert(ALUoutput==44);
        ALUcon = 1;
        #1;
        assert(ALUoutput==24);
        ALUcon = 2;
        #1;
        assert(ALUoutput ==2 );
        ALUcon = 3;
        #1;
        assert(ALUoutput== 42);
        ALUcon = 4;
        #1;
        assert (ALUoutput == 0);
        ALUcon = 5;
        #1;
        assert(hi==4);
        assert(lo== 3);
        ALUcon = 6;
        #1;
        assert(hi==0);
        assert(lo == 340);
        ALUcon = 7;
        #1;
        assert(ALUoutput == 34816);
        ALUcon = 8;
        #1;
        assert(ALUoutput == 40);
        ALUcon =9;
        #1;
        assert(ALUoutput == 0);
        ALUcon =10;
        #1
        assert(ALUoutput ==0);
        $display("Passed testcase a =34, b=10");
        #1;
        reg_read_a = 10;
        alub = 34;
        ALUcon = 0;
        #1;
        assert(ALUoutput==44);
        ALUcon = 1;
        #1;
        assert(ALUoutput==-24);
        ALUcon = 2;
        #1;
        assert(ALUoutput ==2 );
        ALUcon = 3;
        #1;
        assert(ALUoutput== 42);
        ALUcon = 4;
        #1;
        assert (ALUoutput == 1);
        ALUcon = 5;
        #1;
        assert(hi==10);
        assert(lo== 0);
        ALUcon = 6;
        #1;
        assert(hi==0);
        assert(lo == 340);
        ALUcon = 7;
        #1;
        assert(ALUoutput == 0);
        ALUcon = 8;
        #1;
        assert(ALUoutput == 40);
        ALUcon =9;
        #1;
        assert(ALUoutput == 0);
        ALUcon =10;
        #1
        assert(ALUoutput ==0);
        $display("Passed testcase a =10, b=34");
        reg_read_a = 32'b11111111111111111111101010110111;
        alub = 10;
        unsign =0;
        ALUcon = 0;
        #1;
        assert(ALUoutput==-1343);
        $display("Passed Signed ADD Operation");
        #1;
        reg_read_a = 32'b11111111111111111111101010110111;
        alub = 10;
        unsign =0;
        ALUcon = 0;
        #1;
        assert(ALUoutput==4294965953);
        $display("Passed Unigned ADD Operation");
        #1;
        reg_read_a = 32'b11111111111111111111101010110111;
        alub = 10;
        unsign =0;
        ALUcon = 1;
        #1;
        assert(ALUoutput==-1363);
        assert(lt==1);
        $display("Passed Signed Sub Operation");
        #1;
        reg_read_a = 32'b11111111111111111111101010110111;
        alub = 10;
        unsign =1;
        ALUcon = 1;
        #1;
        assert(ALUoutput==4294965933);
        assert(lt==0);
        $display("Passed Unigned Sub Operation");
        reg_read_a = 32'b11111111111111111111101010110111;
        alub = 10;
        unsign =0;
        ALUcon = 4;
        #1;
        assert(ALUoutput==0);
        $display("Passed Signed SLT Operation");
        #1;
        reg_read_a = 10;
        alub = 32'b11111111111111111111101010110111;
        unsign =1;
        ALUcon = 4;
        #1;
        assert(ALUoutput==32'b1);
        $display("Passed Unigned SLT Operation");

        #1;
        unsign=0;
        ALUcon=5;
        reg_read_a = 32'b11111111111111111111101010110111;
        alub = 10;
        #1;
        assert(hi == 4294967293); //-3
        assert(lo == 4294967161); //-135
        $display("Passed Signed MULT Operation");
        #1;
        unsign=1;
        ALUcon=5;
        reg_read_a = 32'b11111111111111111111101010110111;
        alub = 10;
        #1;
        assert(hi==3);
        assert(lo==429496594);
        $display("Passed Unigned MULT Operation");
        #1;
        unsign =0;
        ALUcon=6;
        reg_read_a = 32'b11111111111111111111101010110111;
        alub=10;
        #1; 
        assert(hi==32'd4294967295); 
        assert(lo==32'd4294953766); 
        $display("Passed Signed MULT Operation");
        #1;
        unsign=1;
        #1;
        assert (hi==32'b1001);
        assert(lo==32'b11111111111111111100101100100110);
        $display("Passed Unsigned MULT Operation");
        #1
        reg_read_a = 32'b11111111111111111111101010110111;
        alub=10;
        ALUcon = 9;
        #1;
        assert(ALUoutput == 32'b00000000001111111111111111111110)
        #1;
        reg_read_a = 32'b11111111111111111111101010110111;
        alub=10;
        ALUcon = 10;
        #1;
        assert(ALUoutput == 32'b00000000001111111111111111111110);
        $display("Passed Extra SRA, SRL Operation");
        reg_read_a = 32'b00101001011110001110101010101011;
        alub = 32'b01010101010101010101010101010101;
        ALUcon= 6;
        unsign=0;
        #1;
        assert(hi== 32'b00001101110100101111100011100011);
        assert(lo== 32'b10011100110101111011000111000111);
        $display("Passed Extra Long Multiplication");
        #1;
        unsign =0;
        reg_read_a = 32'b00101001011110001110101010101011;
        alub = 32'b11010101010101010101010101010101;
        #1;
        assert (hi ==32'b11111001000101101000001110001110);
        assert (lo == 32'b00011100110101111011000111000111);
        $display("Passed sign long multiplication");
        unsign=1;
        reg_read_a = 32'b00101001011110001110101010101011;
        alub = 32'b11010101010101010101010101010101;
        #1;




        $finish(0);
    end
endmodule