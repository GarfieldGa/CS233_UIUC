`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/14/2016 11:28:09 AM
// Design Name:
// Module Name: DecimalDigitDecoder_tb
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


module DecimalDigitDecoder_tb(
    );
    reg [3:0] v_in;
    wire [3:0] z_out;
    wire [3:0] m_out;
    integer k;
    DecimalDigitDecoder U1 (.v(v_in), .z(z_out), .m(m_out));

    initial
    begin
        v_in=0;
        for(k=0; k<16; k=k+1)
            #10 v_in=k;
        #20;
    end
endmodule
