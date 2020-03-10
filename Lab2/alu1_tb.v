module alu1_test;
    // exhaustively test your 1-bit ALU implementation by adapting mux4_tb.v
    reg A = 0;
    always #1 A = !A;
    reg B = 0;
    always #2 B = !B;

    reg [2:0] control = 0;

    initial begin
        $dumpfile("alu1.vcd");
        $dumpvars(0, alu1_test);

        // control is initially 0
        # 4 control = 1; // wait 16 time units (why 16?) and then set it to 1
        # 4 control = 2; // wait 16 time units and then set it to 2
        # 4 control = 3; // wait 16 time units and then set it to 3
        # 4 control = 4;
        # 4 control = 5;
        # 4 control = 6;
        # 4 control = 7;
        # 3 $finish; // wait 16 time units and then end the simulation
    end

    wire out;
    alu1 AluOne(out, cout, A, B, 1, control);

    initial
    $monitor("At time %2t, A = %d B = %d control = %d, cout = %d, out = %d",
               $time, A, B, control, cout, out);

endmodule
