`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2026 07:00:49 PM
// Design Name: 
// Module Name: top_lab8
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


module top_lab8(
                input clk,
                input btnc_n,
                input btnr,
                input [7:0] SW,
                output wire [3:0] LED,
                output wire rgb_r, rgb_g, rgb_b
                );
                
       wire rst_n = btnc_n;
       wire clk_1k, clk_pwm;
       
       clock_divider_fixed clk_div(
                                   .clk_in(clk), 
                                   .rst_n(rst_n), 
                                   .clk_1k(clk_1k), 
                                   .clk_pwm(clk_pwm)
                                   );
                                 
       wire load_pulse;
       
       debounce_onepulse #(.STABLE_TICKS(20)) db(
                                                 .clk(clk_1k), 
                                                 .rst_n(rst_n), 
                                                 .din(btnr), 
                                                 .pulse(load_pulse)
                                                 );
                                                   
       wire [1:0] slot;
       wire [3:0] slot_oh;
       wire wr_res, wr_r, wr_g, wr_b;
       
       load_fsm fsm(
                    .clk(clk_1k), 
                    .rst_n(rst_n), 
                    .load_pulse(load_pulse),
                    .slot(slot), 
                    .slot_onehot(slot_oh),
                    .wr_res(wr_res), 
                    .wr_r(wr_r), 
                    .wr_g(wr_g), 
                    .wr_b(wr_b)
                    );
                    
       assign LED = slot_oh;
       reg [7:0] reg_res, reg_r, reg_g, reg_b;
       
       always @(posedge clk_1k or negedge rst_n) 
        begin
            if (!rst_n) 
                begin 
                    reg_res<=8'd63; 
                    reg_r<=0; reg_g<=0; 
                    reg_b<=0; 
                end
            else 
                begin
                    if (wr_res)
                        begin 
                            reg_res <= SW;
                        end
                    if (wr_r)
                        begin 
                            reg_r <= SW;
                        end
                    if (wr_g)
                        begin 
                            reg_g <= SW;
                        end
                    if (wr_b) 
                        begin
                            reg_b <= SW;
                        end
                end
        end
                     
       reg [7:0] res_q1,res_q2,r_q1,r_q2,g_q1,g_q2,b_q1,b_q2;
       
       always @(posedge clk_pwm or negedge rst_n) 
        begin
            if (!rst_n) 
                begin 
                    res_q1<=0; 
                    res_q2<=0; 
                    r_q1<=0; 
                    r_q2<=0; 
                    g_q1<=0;
                    g_q2<=0; 
                    b_q1<=0; 
                    b_q2<=0; 
                end
            else 
                begin
                   res_q1<=reg_res; 
                   res_q2<=res_q1;
                   r_q1<=reg_r; 
                   r_q2<=r_q1; 
                   g_q1<=reg_g; 
                   g_q2<=g_q1; 
                   b_q1<=reg_b;
                   b_q2<=b_q1;
               end
        end
        
       wire pwm_r, pwm_g, pwm_b;
       
       pwm_core pwm(
                    .clk(clk_pwm), 
                    .rst_n(rst_n),
                    .period(res_q2), 
                    .duty_r(r_q2), 
                    .duty_g(g_q2), 
                    .duty_b(b_q2),
                    .pwm_r(pwm_r), 
                    .pwm_g(pwm_g), 
                    .pwm_b(pwm_b)
                    );                 
                    
       rgb_led_driver #(.ACTIVE_LOW(0)) drive_led(
                                                  .pwm_r(pwm_r), 
                                                  .pwm_g(pwm_g), 
                                                  .pwm_b(pwm_b),
                                                  .led_r(rgb_r), 
                                                  .led_g(rgb_g), 
                                                  .led_b(rgb_b)
                                                  ); 
                                                                                                                                       
endmodule
