`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 11:02:55 AM
// Design Name: 
// Module Name: mux32x1
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


module mux32x1(
               input wire [31:0] cnt,
               input wire [4:0] sel,
               output wire clk_div
               );
               
               assign clk_div = cnt[31-sel];
endmodule
