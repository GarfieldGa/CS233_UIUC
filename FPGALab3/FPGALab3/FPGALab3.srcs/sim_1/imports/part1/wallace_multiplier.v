module wallace_old(p, a, b);
    output[7:0]  p;
    input[3:0]  a, b;
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, s1, s2, s3, s4, s5, s6, s7, s8, s9;

    assign p[0] = a[0] & b[0];
    halfadder a0(p[1], c1, a[1] & b[0], a[0] & b[1]);
    fulladder f0(s1, c2, a[0] & b[2], a[1] & b[1], a[2] & b[0]);
    halfadder a1(p[2], c6, c1, s1);
    fulladder f1(s2, c3, a[1] & b[2], a[2] & b[1], a[3] & b[0]);
    fulladder f2(s3, c4, a[1] & b[3], a[2] & b[2], a[3] & b[1]);
    halfadder h1(s4, c5, a[2] & b[3], a[3] & b[2]);
    fulladder f3(s5, c7, a[0] & b[3], s2, c2);
    halfadder h2(s6, c8, s3, c3);
    halfadder h3(s7, c9, s4, c4);
    halfadder h4(s8, c14, a[3] & b[3], c5);
    halfadder h5(p[3], c10, s5, c6);
    fulladder f4(p[4], c11, s6, c7, c10);
    fulladder f5(p[5], c12, s7, c8, c11);
    fulladder f6(p[6], c13, s8, c9, c12);
    halfadder h6(p[7], , c14, c13);

endmodule