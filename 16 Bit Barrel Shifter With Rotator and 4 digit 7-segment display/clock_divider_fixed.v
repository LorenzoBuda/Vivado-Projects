`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2026 12:34:47 PM
// Design Name: 
// Module Name: clock_divider_fixed
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


module clock_divider_fixed (
                            input clk_100mhz,
                            input rst,          
                            output reg clk_1khz,     
                            output reg clk_2hz       
                            );

        localparam CNT_1KHZ_MAX = 17'd50_000  - 1'b1;  
        localparam CNT_2HZ_MAX  = 25'd25_000_000 - 1'b1; 
    
        reg [16:0] cnt_1khz;
        reg [24:0] cnt_2hz;
    
        always @(posedge clk_100mhz or posedge rst) 
            begin
                if (rst) 
                    begin
                        cnt_1khz <= 17'd0;
                        clk_1khz <= 1'b0;
                    end 
                else if (cnt_1khz == CNT_1KHZ_MAX) 
                    begin
                        cnt_1khz <= 17'd0;
                        clk_1khz <= ~clk_1khz;
                    end 
                else 
                    begin
                        cnt_1khz <= cnt_1khz + 1'b1;
                    end
            end
    
        always @(posedge clk_100mhz or posedge rst) 
            begin
                if (rst) 
                    begin
                        cnt_2hz <= 25'd0;
                        clk_2hz <= 1'b0;
                    end 
                else if (cnt_2hz == CNT_2HZ_MAX) 
                    begin
                        cnt_2hz <= 25'd0;
                        clk_2hz <= ~clk_2hz;
                    end 
                else 
                    begin
                        cnt_2hz <= cnt_2hz + 1'b1;
                    end
            end 

endmodule
