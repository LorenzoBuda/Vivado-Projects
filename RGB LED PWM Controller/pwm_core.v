`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2026 06:55:08 PM
// Design Name: 
// Module Name: pwm_core
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


module pwm_core(
                input clk,
                input rst_n,
                input [7:0] period,
                input [7:0] duty_r, duty_g, duty_b,
                output reg pwm_r, pwm_g, pwm_b
                );
                
       wire [8:0] eff_period = {1'b0, period} + 9'd1;
       
        function [8:0] clamp9(input [7:0] d);
            clamp9 = ( {1'b0,d} >= eff_period ) ? (eff_period - 9'd1) : {1'b0,d};
        endfunction
        
        reg [8:0] cnt;
        
        always @(posedge clk or negedge rst_n) 
            begin
                if (!rst_n)
                    begin 
                        cnt <= 0;
                    end
            else if (cnt == eff_period - 1)
                begin 
                    cnt <= 0;
                end
            else 
                begin
                    cnt <= cnt + 1;
                end
            end
            
        always @(posedge clk or negedge rst_n) 
            begin
                if (!rst_n)
                    begin 
                        {pwm_r, pwm_g, pwm_b} <= 0;
                    end
                else 
                    begin
                        pwm_r <= (cnt < clamp9(duty_r));
                        pwm_g <= (cnt < clamp9(duty_g));
                        pwm_b <= (cnt < clamp9(duty_b));
                    end
            end     
endmodule
