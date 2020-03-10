`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/08/2016 04:44:47 PM
// Design Name:
// Module Name: clock_divider_tb
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


module clock_divider_tb(
    );
    reg clk;
    wire clk_out;
    clock_divider d1 (.clk_in(clk), .clk_out(clk_out));
    initial
        clk = 1'b0;
    always
        #20 clk=~clk;

endmodule
