module BCDToLED(x, clk_out, seg, an);
        input[3:0] x;
        input clk_out;
        output[6:0] seg;
        output[3:0] an;

        assign seg[0] = (~x[3] & ~x[2] & ~x[1] & x[0]) | (x[2] & ~x[1] & ~x[0]);
        assign seg[1] = (x[2] & ~x[1] & x[0]) | (x[2] & x[1] & ~x[0]);
        assign seg[2] = ~x[2] & x[1] & ~x[0];
        assign seg[3] = (x[2] & ~x[1] & ~x[0]) | (~x[3] & ~x[2] & ~x[1] & x[0]) | (x[0] & x[1] & x[2]);
        assign seg[4] = (~x[1] & x[2]) | x[0];
        assign seg[5] = (~x[3] & ~x[2] & x[0]) | (x[1] & x[0]) | (~x[2] & x[1]);
        assign seg[6] = (~x[1] & ~x[3] & ~x[2]) | (x[1] & x[0] & x[2]);
        assign an[3:0] = 4'b1110 ^ {2'b00, clk_out, clk_out};
endmodule

module Comparator(input[3:0] v, output[3:0] z);
        assign z[0] = (v[3] & v[2]) | (v[3] & v[1]);
        assign z[1] = 0;
        assign z[2] = 0;
        assign z[3] = 0;
endmodule

module CircuitA(input[3:0] v, output[3:0] m, input[3:0] z);
        assign m[0] = v[0];
        assign m[1] = z[0] ^ v[1];
        assign m[2] = (v[3] & v[2] & ~v[1]) ^ v[2];
        assign m[3] = v[3] & ~z[0];
endmodule

module DecimalDigitDecoder(input[3:0] v, output[3:0] z, output[3:0] m);
        Comparator c1(v, z);
        CircuitA c2(v, m, z);
endmodule

module top_level(x, clk_in, seg, an);
        input clk_in;
        input[3:0] x;
        output[3:0] an;
        output[6:0] seg;
        wire[3:0] m, z, an1, an2;
        wire clk_out;
        wire[6:0] seg1, seg2;
        
        clock_divider cdivider(clk_in, clk_out);
        DecimalDigitDecoder ddd(x, z, m);
        BCDToLED bcd1(m, clk_out, seg1, an1);
        BCDToLED bcd2(z, clk_out, seg2, an2);
        mux2v #(7) mux_seg(seg, seg1, seg2, clk_out);
        mux2v #(4) mux_an(an, an1, an2, clk_out);
endmodule
