module full_adder(sum, cout, a, b, cin, control);
    output sum, cout;
    input  a, b, cin, control;
    wire   b_new, partial_s, out1, out2, out3, partial_out;

    xor xor1(b_new, b, control);
    xor xor2(partial_s, b_new, a);
    xor xor3(sum, partial_s, cin);
    and and1(out1, b_new, a);
    and and2(out2, b_new, cin);
    and and3(out3, a, cin);
    or or1(partial_out, out1, out2);
    or or2(cout, partial_out, out3);
endmodule // full_adder

`define ALU_ADD    3'h2
`define ALU_SUB    3'h3
`define ALU_AND    3'h4
`define ALU_OR     3'h5
`define ALU_NOR    3'h6
`define ALU_XOR    3'h7

// 01x -> arithmetic, 1xx -> logic
module alu1(out, carryout, A, B, carryin, control);
    output      out, carryout;
    input       A, B, carryin;
    input [2:0] control;
    wire sum, c_out, out2, out1;
    // add code here!!!
    full_adder adder1(sum, c_out, A, B, carryin, control[0]);
    logicunit logic1(out2, A, B, control[1:0]);
    mux2 m21(out1, 0, sum, control[1]);
    mux2 m22(out, out1, out2, control[2]);
    mux4 m4(carryout, 0, 0, c_out, c_out, control[1:0]);
endmodule // alu1
