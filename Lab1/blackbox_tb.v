module blackbox_test;
  reg n_in, u_in, r_in;
  wire o_out;
  blackbox box(o_out, n_in, u_in, r_in);

  initial begin

    $dumpfile("blackbox.vcd");
    $dumpvars(0,blackbox_test);

    n_in = 0; u_in = 0; r_in = 0; # 10;
    n_in = 0; u_in = 0; r_in = 1; # 10;
    n_in = 0; u_in = 1; r_in = 0; # 10;
    n_in = 0; u_in = 1; r_in = 1; # 10;
    n_in = 1; u_in = 0; r_in = 0; # 10;
    n_in = 1; u_in = 0; r_in = 1; # 10;
    n_in = 1; u_in = 1; r_in = 0; # 10;
    n_in = 1; u_in = 1; r_in = 1; # 10;

    $finish;

  end

  initial
      $monitor("At time %2t, n_in = %d u_in = %d r_in = %d, o_out = %d",
               $time, n_in, u_in, r_in, o_out);
endmodule // blackbox_test
