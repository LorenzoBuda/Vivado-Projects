`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2026 12:43:48 PM
// Design Name: 
// Module Name: seg7_scan8
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


module seg7_scan8 (
                    input clk_1khz,   
                    input rst,        
                    input [15:0] data_in,    
                    output reg [7:0] an,         
                    output [6:0] seg
                   );

        reg [2:0] digit_sel;
    
        always @(posedge clk_1khz or posedge rst) 
            begin
                if (rst)
                    begin
                        digit_sel <= 3'd0;
                    end
                else
                    begin
                        digit_sel <= digit_sel + 1'b1;
                    end
            end
    
        reg [3:0] nibble;
        always @(*) 
            begin
                case (digit_sel[1:0])
                    2'b00: nibble = data_in[3:0];
                    2'b01: nibble = data_in[7:4];
                    2'b10: nibble = data_in[11:8];
                    2'b11: nibble = data_in[15:12];
                endcase
            end
    
        always @(*) 
            begin
                an = 8'hFF; // all digits off by default
                    case (digit_sel)
                        3'd0: an[0] = 1'b0;
                        3'd1: an[1] = 1'b0;
                        3'd2: an[2] = 1'b0;
                        3'd3: an[3] = 1'b0;
                        default: an = 8'hFF;
                    endcase
            end
    
        hex_to_7seg u_h2s (
                            .hex(nibble),
                            .seg(seg)
                           );

endmodule
