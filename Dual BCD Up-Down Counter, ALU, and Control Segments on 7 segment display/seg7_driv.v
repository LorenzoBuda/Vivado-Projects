`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 11:05:57 AM
// Design Name: 
// Module Name: seg7_driv
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


module seg7_driv(
                 input clk,
                 input rst_n,
                 input [3:0] ones,
                 input [3:0] tens,
                 output reg [6:0] seg,
                 output reg [1:0] AN
                 );
                 
                 reg [15:0] tmp;
                    wire digit;
                   
                    always@(posedge clk or negedge rst_n)
                        begin
                            if(!rst_n)
                                begin
                                    tmp <= 16'b0;
                                end
                            else
                                tmp <= tmp + 1;    
                        end
                        
                   assign digit = tmp[15];
                   
                   reg [3:0] current_bcd;
                   
                   always@(*)
                    begin
                        case(digit)
                            1'b0: begin
                                current_bcd = ones;
                                AN = 2'b10;
                                end
                            1'b1: begin
                                current_bcd = tens;
                                AN = 2'b01;
                                end
                        default: begin
                            current_bcd = ones;
                            AN = 2'b11;
                            end
                        endcase        
                     end
                  
                  always@(*)
                    begin
                        case(current_bcd)
                            4'd0: seg = 7'b1000000;//0
                            4'd1: seg = 7'b1111001;//1
                            4'd2: seg = 7'b0100100;//2
                            4'd3: seg = 7'b0110000;//3
                            4'd4: seg = 7'b0011001;//4
                            4'd5: seg = 7'b0010010;//5
                            4'd6: seg = 7'b0000010;//6
                            4'd7: seg = 7'b1111000;//7
                            4'd8: seg = 7'b0000000;//8
                            4'd9: seg = 7'b0010000;//9
                            default: seg = 7'b1111111;//All Off
                        endcase    
                    end
endmodule
