//implement your 32-bit ALU
module alu32(out, overflow, zero, negative, A, B, control);
    output [31:0] out;
    output        overflow, zero, negative;
    input  [31:0] A, B;
    input   [2:0] control;
    wire [31:0] cout, zeroCount;

    alu1 alu0(out[0], cout[0], A[0], B[0], control[0], control);
    alu1 alu1(out[1], cout[1], A[1], B[1], cout[0], control);
    alu1 alu2(out[2], cout[2], A[2], B[2], cout[1], control);
    alu1 alu3(out[3], cout[3], A[3], B[3], cout[2], control);
    alu1 alu4(out[4], cout[4], A[4], B[4], cout[3], control);
    alu1 alu5(out[5], cout[5], A[5], B[5], cout[4], control);
    alu1 alu6(out[6], cout[6], A[6], B[6], cout[5], control);
    alu1 alu7(out[7], cout[7], A[7], B[7], cout[6], control);
    alu1 alu8(out[8], cout[8], A[8], B[8], cout[7], control);
    alu1 alu9(out[9], cout[9], A[9], B[9], cout[8], control);
    alu1 alu10(out[10], cout[10], A[10], B[10], cout[9], control);
    alu1 alu11(out[11], cout[11], A[11], B[11], cout[10], control);
    alu1 alu12(out[12], cout[12], A[12], B[12], cout[11], control);
    alu1 alu13(out[13], cout[13], A[13], B[13], cout[12], control);
    alu1 alu14(out[14], cout[14], A[14], B[14], cout[13], control);
    alu1 alu15(out[15], cout[15], A[15], B[15], cout[14], control);
    alu1 alu16(out[16], cout[16], A[16], B[16], cout[15], control);
    alu1 alu17(out[17], cout[17], A[17], B[17], cout[16], control);
    alu1 alu18(out[18], cout[18], A[18], B[18], cout[17], control);
    alu1 alu19(out[19], cout[19], A[19], B[19], cout[18], control);
    alu1 alu20(out[20], cout[20], A[20], B[20], cout[19], control);
    alu1 alu21(out[21], cout[21], A[21], B[21], cout[20], control);
    alu1 alu22(out[22], cout[22], A[22], B[22], cout[21], control);
    alu1 alu23(out[23], cout[23], A[23], B[23], cout[22], control);
    alu1 alu24(out[24], cout[24], A[24], B[24], cout[23], control);
    alu1 alu25(out[25], cout[25], A[25], B[25], cout[24], control);
    alu1 alu26(out[26], cout[26], A[26], B[26], cout[25], control);
    alu1 alu27(out[27], cout[27], A[27], B[27], cout[26], control);
    alu1 alu28(out[28], cout[28], A[28], B[28], cout[27], control);
    alu1 alu29(out[29], cout[29], A[29], B[29], cout[28], control);
    alu1 alu30(out[30], cout[30], A[30], B[30], cout[29], control);
    alu1 alu31(out[31], cout[31], A[31], B[31], cout[30], control);

    xor xor1(overflow, cout[31], cout[30]);
    assign negative = out[31];

    or or0(zeroCount[0], out[0], 0);
    or or1(zeroCount[1], out[1], zeroCount[0]);
    or or2(zeroCount[2], out[2], zeroCount[1]);
    or or3(zeroCount[3], out[3], zeroCount[2]);
    or or4(zeroCount[4], out[4], zeroCount[3]);
    or or5(zeroCount[5], out[5], zeroCount[4]);
    or or6(zeroCount[6], out[6], zeroCount[5]);
    or or7(zeroCount[7], out[7], zeroCount[6]);
    or or8(zeroCount[8], out[8], zeroCount[7]);
    or or9(zeroCount[9], out[9], zeroCount[8]);
    or or10(zeroCount[10], out[10], zeroCount[9]);
    or or11(zeroCount[11], out[11], zeroCount[10]);
    or or12(zeroCount[12], out[12], zeroCount[11]);
    or or13(zeroCount[13], out[13], zeroCount[12]);
    or or14(zeroCount[14], out[14], zeroCount[13]);
    or or15(zeroCount[15], out[15], zeroCount[14]);
    or or16(zeroCount[16], out[16], zeroCount[15]);
    or or17(zeroCount[17], out[17], zeroCount[16]);
    or or18(zeroCount[18], out[18], zeroCount[17]);
    or or19(zeroCount[19], out[19], zeroCount[18]);
    or or20(zeroCount[20], out[20], zeroCount[19]);
    or or21(zeroCount[21], out[21], zeroCount[20]);
    or or22(zeroCount[22], out[22], zeroCount[21]);
    or or23(zeroCount[23], out[23], zeroCount[22]);
    or or24(zeroCount[24], out[24], zeroCount[23]);
    or or25(zeroCount[25], out[25], zeroCount[24]);
    or or26(zeroCount[26], out[26], zeroCount[25]);
    or or27(zeroCount[27], out[27], zeroCount[26]);
    or or28(zeroCount[28], out[28], zeroCount[27]);
    or or29(zeroCount[29], out[29], zeroCount[28]);
    or or30(zeroCount[30], out[30], zeroCount[29]);
    or or31(zeroCount[31], out[31], zeroCount[30]);
    not not1(zero, zeroCount[31]);

endmodule // alu32
