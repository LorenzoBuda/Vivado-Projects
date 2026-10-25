`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2026 03:59:10 PM
// Design Name: 
// Module Name: top_lab5
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


module top_lab5(
                input clk,
                input rst, //BTNC
                input [4:0] SW,
                input up_down, //BTNU
                output wire [12:0] LED,
                output wire [6:0] SEG,
                output wire [1:0] AN
                );
                
                wire reset_clean;
                wire up_down_clean;
                wire clk_division;
                wire [31:0] count;
                wire [3:0] digit0, digit1;
                wire u_rollover;

                
       debounce reset(
                      .clk(clk),
                      .btn_in(rst),
                      .btn_clean(reset_clean)
                      );
                      
        debounce direction(
                      .clk(clk),
                      .btn_in(up_down),
                      .btn_clean(up_down_clean)
                      );              
       
       clock_divider clk_div(
                             .clk_div(clk),
                             .rst_n(reset_clean),
                             .cnt(count)
                             );  
       
       mux32x1 mux(
                   .cnt(count),
                   .sel(SW),
                   .clk_div(clk_division)
                   );                        
       
       bcd_up_down_counter ones_units(
                                      .clk_div(clk_division),
                                      .reset(reset_clean),
                                      .dir(up_down_clean),
                                      .bcd_out(digit0),
                                      .rollover(u_rollover)
                                      );
                                      
       bcd_up_down_counter tens_units(
                                      .clk_div(u_rollover),
                                      .reset(reset_clean),
                                      .dir(up_down_clean),
                                      .bcd_out(digit1),
                                      .rollover()
                                      );
                                                            
       seg7_scan display(
                         .clk(clk),
                         .rst_n(reset_clean),
                         .tens(digit1),
                         .ones(digit0),
                         .seg(SEG),
                         .AN(AN)
                         );                               
               
       assign LED[4:0] = SW;
       assign LED[8:5] = digit0;
       assign LED[12:9] = digit1;                              
                                               
endmodule
