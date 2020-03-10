`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 01:55:53 PM
// Design Name: 
// Module Name: top_level
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module BCDToLED(x, seg);
        input[3:0] x;
        output[6:0] seg;

        assign seg[0] = (~x[3] & ~x[2] & ~x[1] & x[0]) | (x[2] & ~x[1] & ~x[0]);
        assign seg[1] = (x[2] & ~x[1] & x[0]) | (x[2] & x[1] & ~x[0]);
        assign seg[2] = ~x[2] & x[1] & ~x[0];
        assign seg[3] = (x[2] & ~x[1] & ~x[0]) | (~x[3] & ~x[2] & ~x[1] & x[0]) | (x[0] & x[1] & x[2]);
        assign seg[4] = (~x[1] & x[2]) | x[0];
        assign seg[5] = (~x[3] & ~x[2] & x[0]) | (x[1] & x[0]) | (~x[2] & x[1]);
        assign seg[6] = (~x[1] & ~x[3] & ~x[2]) | (x[1] & x[0] & x[2]);
endmodule

module clock_divider(
    input clk_in,
    output clk_out
    );
    reg [31:0] counter = 1;
    reg temp_clk = 0;
    always @ (posedge(clk_in))
    begin
        if (counter == 5000
        )
        begin
            counter <= 1;
            temp_clk <= ~temp_clk;
        end
        else
            counter <= counter + 1;
     end
     assign clk_out = temp_clk;
endmodule

module top_level(input[3:0] a,
                input[3:0] b,
                input clk,
                output[6:0] seg,
                output[3:0] an
                );
                wire clk_out;
                wire[7:0] p;
                wire[3:0] hundreds, tens, ones, ann;
                wire[6:0] seg1, seg2, seg3;
        clock_divider tik_tok(clk, clk_out);
        reg[2:0] count = 1;
        always @ (posedge(clk_out)) begin
            if (count == 4) begin
                count <= 0;
            end else
                count <= count + 1;
        end
        assign ann[3] = 1'b0;
        assign ann[2] = count[0] & count[1]; // 1 when count = 2'b11 = 3
        assign ann[1] = ann[2] ^ count[1]; // count[1] = 1; count[0] = 0 (count == 2'b1)
        assign ann[0] = ann[2] ^ count[0]; // count[1] = 0; count[0] = 1
        assign an = ann ^ 4'b1111;
        wallace multiplier(p, a, b);
        DecimalDigitDecoder decoder(p, hundreds, tens, ones);
        BCDToLED bcd3(hundreds, seg3);
        BCDToLED bcd2(tens, seg2);
        BCDToLED bcd1(ones, seg1);
        mux4v #(7) bcd_mux(seg, 7'b0, seg1, seg2, seg3, count[1:0]);
endmodule
