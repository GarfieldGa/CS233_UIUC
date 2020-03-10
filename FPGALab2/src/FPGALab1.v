module BCDToLED(x, seg, an);
        input[3:0] x;
        output[6:0] seg;
        output[3:0] an;

        assign seg[0] = (~x[3] & ~x[2] & ~x[1] & x[0]) | (x[2] & ~x[1] & ~x[0]);
        assign seg[1] = (x[2] & ~x[1] & x[0]) | (x[2] & x[1] & ~x[0]);
        assign seg[2] = ~x[2] & x[1] & ~x[0];
        assign seg[3] = (x[2] & ~x[1] & ~x[0]) | (~x[3] & ~x[2] & ~x[1] & x[0]) | (x[0] & x[1] & x[2]);
        assign seg[4] = (~x[1] & x[2]) | x[0];
        assign seg[5] = (~x[3] & ~x[2] & x[0]) | (x[1] & x[0]) | (~x[2] & x[1]);
        assign seg[6] = (~x[1] & ~x[3] & ~x[2]) | (x[1] & x[0] & x[2]);

        assign an[3:0] = 4'b1110;

endmodule

module Comparator(input[3:0] v, output z);
        assign z = (v[3] & v[2]) | (v[3] & v[1]);
endmodule

module CircuitA(input[3:0] v, output[3:0] m, input z);
        assign m[0] = v[0];
        assign m[1] = z ^ v[1];
        assign m[2] = (v[3] & v[2] & ~v[1]) ^ v[2];
        assign m[3] = v[3] & ~z;
endmodule

module DecimalDigitDecoder(input[3:0] v, output z, output[3:0] m);
        Comparator c1(v, z);
        CircuitA c2(v, m, z);
endmodule

module top_level(x, seg, an, led);
        input[3:0] x;
        output[3:0] an;
        output[6:0] seg;
        output led;
        wire[3:0] m;
        
        DecimalDigitDecoder(x, led, m);
        BCDToLED(m, seg, an);
endmodule
