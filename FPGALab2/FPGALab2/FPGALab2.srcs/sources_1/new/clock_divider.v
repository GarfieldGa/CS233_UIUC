`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2019 04:12:38 PM
// Design Name: 
// Module Name: clock_divider
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
