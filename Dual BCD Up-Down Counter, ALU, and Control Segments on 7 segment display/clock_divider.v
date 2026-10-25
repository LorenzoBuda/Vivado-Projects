`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 11:04:00 AM
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
                     input clk_div,
                     input rst_n,
                     output reg [31:0] cnt
                     );
                     
          always@(posedge clk_div or negedge rst_n)
            begin
                if(!rst_n)
                    begin
                        cnt <= 0;
                    end
                else
                    cnt <= cnt + 1;    
            end   
endmodule
