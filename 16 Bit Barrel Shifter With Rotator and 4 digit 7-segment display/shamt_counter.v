`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2026 12:39:37 PM
// Design Name: 
// Module Name: shamt_counter
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


module shamt_counter (
                        input clk_1khz,           
                        input rst,                
                        input btnc_pressed_edge,  
                        output reg [1:0] count               
                      );

        always @(posedge clk_1khz or posedge rst) 
            begin
                if (rst)
                    begin
                        count <= 2'b00;
                    end
            else if (btnc_pressed_edge)
                begin
                    count <= count + 1'b1;
                end
            end

endmodule
