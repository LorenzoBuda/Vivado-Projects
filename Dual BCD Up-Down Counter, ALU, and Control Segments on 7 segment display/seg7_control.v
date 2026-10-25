`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 01:27:34 PM
// Design Name: 
// Module Name: seg7_control
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


module seg7_control(
                    input clk,
                    input rst_n,
                    input [3:0] control,
                    output reg [6:0] seg,
                    output reg  AN
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
                  
                  always@(*)
                    begin
                        case(control)
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
                        AN = 1'b0;   
                    end
endmodule
