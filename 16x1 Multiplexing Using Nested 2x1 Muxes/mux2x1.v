`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2026 03:49:47 PM
// Design Name: 
// Module Name: mux2x1
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


module mux2x1(
              input a,
              input b,
              input sel,
              output y
              );
              
          wire nsel, a1, b1;
          not (nsel, sel);
          and (a1, a, nsel);
          and (b1, b, sel);
          or (y, a1, b1);    
endmodule
