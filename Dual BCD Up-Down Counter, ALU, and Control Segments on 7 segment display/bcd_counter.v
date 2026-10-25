`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 11:00:34 AM
// Design Name: 
// Module Name: bcd_counter
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


module bcd_counter(
                   input clk_div,
                   input reset,
                   input dir,
                   output reg [3:0] bcd_out,
                   output reg rollover
                   );
                   
                   always@(posedge clk_div or negedge reset)
                begin
                    if(!reset)
                        begin
                            bcd_out <= 4'b0;
                            rollover <= 1'b0;
                        end
                    else
                        begin    
                            if(dir)
                                begin
                                    if(bcd_out == 4'd9)
                                        begin
                                            bcd_out <= 4'b0;
                                            rollover <= 1'b1;
                                        end
                                    else
                                        begin
                                            bcd_out <= bcd_out + 1;
                                            rollover <= 1'b0;
                                        end    
                                end    
                            else
                                begin
                                    if(bcd_out == 4'd0)
                                        begin
                                            bcd_out <= 4'd9;
                                            rollover <= 1'b1;
                                        end
                                     else       
                                        begin
                                            bcd_out <= bcd_out - 1;
                                            rollover <= 1'b0;
                                        end    
                                end 
                        end                    
                end
endmodule
