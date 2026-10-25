`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 11:26:20 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
           input [3:0] u_ones,
           input [3:0] u_tens,
           input [1:0] add_sub,
           output reg [7:0] result
           );
           
      always@(*)
        begin
            if(add_sub == 2'b00)
                begin
                    result = u_ones + u_tens;
                end
             else if(add_sub == 2'b01)
                begin
                    result = u_ones - u_tens;
                end
             else
                begin
                    result = 8'b0;
                end      
        end
          
endmodule
