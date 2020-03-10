module keypad(valid, number, a, b, c, d, e, f, g);
   output 	valid;
   output [3:0] number;
   input 	a, b, c, d, e, f, g;
   wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w0;

   and a1(w1, a, d);
   and a2(w4, a, e);
   and a3(w7, a, f);
   and a4(w2, b, d);
   and a5(w5, b, e);
   and a6(w8, b, f);
   and a7(w0, b, g);
   and a8(w3, c, d);
   and a9(w6, c, e);
   and a10(w9, c, f);
   or or1(valid, w0, w1, w2, w3, w4, w5, w6, w7, w8, w9);

   or n0(number[0], w1, w3, w5, w7, w9);
   or n1(number[1], w2, w3, w6, w7);
   or n2(number[2], w4, w5, w6, w7);
   or n3(number[3], w8, w9);

endmodule // keypad
