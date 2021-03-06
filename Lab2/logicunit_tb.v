module logicunit_test;
    // exhaustively test your logic unit implementation by adapting mux4_tb.v
    reg A = 0;
    always #1 A = !A;
    reg B = 0;
    always #2 B = !B;

    reg [1:0] control = 0;

    initial begin
        $dumpfile("logicunit.vcd");
        $dumpvars(0, logicunit_test);

        // control is initially 0
        # 4 control = 1; // wait 16 time units (why 16?) and then set it to 1
        # 4 control = 2; // wait 16 time units and then set it to 2
        # 4 control = 3; // wait 16 time units and then set it to 3
        # 3 $finish; // wait 16 time units and then end the simulation
    end

    wire out;
    logicunit logic1(out, A, B, control);

    initial
    $monitor("At time %2t, A = %d B = %d control = %d, out = %d",
               $time, A, B, control, out);

endmodule // logicunit_test
