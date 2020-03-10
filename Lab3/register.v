// register: A register which may be reset to an arbirary value
//
// q      (output) - Current value of register
// d      (input)  - Next value of register
// clk    (input)  - Clock (positive edge-sensitive)
// enable (input)  - Load new value? (yes = 1, no = 0)
// reset  (input)  - Asynchronous reset    (reset = 1)
//
module register(q, d, clk, enable, reset);

    output [31:0] q;
    input  [31:0] d;
    input  clk, enable, reset;

   //  Your implementation goes here
   dffe FlipFlop0(q[0], d[0], clk, enable, reset);
   dffe FlipFlop1(q[1], d[1], clk, enable, reset);
   dffe FlipFlop2(q[2], d[2], clk, enable, reset);
   dffe FlipFlop3(q[3], d[3], clk, enable, reset);
   dffe FlipFlop4(q[4], d[4], clk, enable, reset);
   dffe FlipFlop5(q[5], d[5], clk, enable, reset);
   dffe FlipFlop6(q[6], d[6], clk, enable, reset);
   dffe FlipFlop7(q[7], d[7], clk, enable, reset);
   dffe FlipFlop8(q[8], d[8], clk, enable, reset);
   dffe FlipFlop9(q[9], d[9], clk, enable, reset);
   dffe FlipFlop10(q[10], d[10], clk, enable, reset);
   dffe FlipFlop11(q[11], d[11], clk, enable, reset);
   dffe FlipFlop12(q[12], d[12], clk, enable, reset);
   dffe FlipFlop13(q[13], d[13], clk, enable, reset);
   dffe FlipFlop14(q[14], d[14], clk, enable, reset);
   dffe FlipFlop15(q[15], d[15], clk, enable, reset);
   dffe FlipFlop16(q[16], d[16], clk, enable, reset);
   dffe FlipFlop17(q[17], d[17], clk, enable, reset);
   dffe FlipFlop18(q[18], d[18], clk, enable, reset);
   dffe FlipFlop19(q[19], d[19], clk, enable, reset);
   dffe FlipFlop20(q[20], d[20], clk, enable, reset);
   dffe FlipFlop21(q[21], d[21], clk, enable, reset);
   dffe FlipFlop22(q[22], d[22], clk, enable, reset);
   dffe FlipFlop23(q[23], d[23], clk, enable, reset);
   dffe FlipFlop24(q[24], d[24], clk, enable, reset);
   dffe FlipFlop25(q[25], d[25], clk, enable, reset);
   dffe FlipFlop26(q[26], d[26], clk, enable, reset);
   dffe FlipFlop27(q[27], d[27], clk, enable, reset);
   dffe FlipFlop28(q[28], d[28], clk, enable, reset);
   dffe FlipFlop29(q[29], d[29], clk, enable, reset);
   dffe FlipFlop30(q[30], d[30], clk, enable, reset);
   dffe FlipFlop31(q[31], d[31], clk, enable, reset);

endmodule // register



// dffe: D-type flip-flop with enable
//
// q      (output) - Current value of flip flop
// d      (input)  - Next value of flip flop
// clk    (input)  - Clock (positive edge-sensitive)
// enable (input)  - Load new value? (yes = 1, no = 0)
// reset  (input)  - Asynchronous reset   (reset =  1)
//
module dffe(q, d, clk, enable, reset);
   output q;
   reg    q;
   input  d;
   input  clk, enable, reset;

   always@(reset)
     if (reset == 1'b1)
       q <= 0;

   always@(posedge clk)
     if ((reset == 1'b0) && (enable == 1'b1))
       q <= d;
endmodule // dffe
