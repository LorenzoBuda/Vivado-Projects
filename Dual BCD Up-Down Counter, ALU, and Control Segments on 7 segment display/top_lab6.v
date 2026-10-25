`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 11:09:13 AM
// Design Name: 
// Module Name: top_lab6
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


module top_lab6(
                input clk,
                input rst,
                input [8:0] SW,
                output wire [7:0] LED,
                output wire [6:0] SEG_num,
                output wire [6:0] SEG_control,
                output wire [2:0] AN
                );
                
                wire reset_clean;
                wire clk_division;
                wire [31:0] count;
                wire [3:0] digit0, digit1;
                wire u_rollover;
                wire [7:0] alu_result;
                wire [3:0] tmp1, tmp2;
                
        clock_divider clk_div(
                              .clk_div(clk),
                              .rst_n(reset_clean),
                              .cnt(count)
                              ); 
                              
       debounce reset(
                      .clk(clk),
                      .btn_in(rst),
                      .btn_clean(reset_clean)
                      );
                      
       mux32x1 mux(
                   .cnt(count),
                   .sel(SW[4:0]),
                   .clk_div(clk_division)
                   );  
                   
       bcd_counter u_ones(
                          .clk_div(clk_division),
                          .reset(reset_clean),
                          .dir(SW[7]),
                          .bcd_out(digit0),
                          .rollover(u_rollover)
                          );
                          
       bcd_counter u_tens(
                          .clk_div(u_rollover),
                          .reset(reset_clean),
                          .dir(SW[8]),
                          .bcd_out(digit1),
                          .rollover()
                          );
                          
                     assign tmp1 = digit0;
                     assign tmp2 = digit1;  
                     
       ALU add_or_sub(
                      .u_ones(digit0),
                      .u_tens(digit1),
                      .add_sub(SW [6:5]),
                      .result(alu_result)
                      );
                                               
       seg7_driv units_num(
                              .clk(clk_division),
                              .rst_n(reset_clean),
                              .ones(alu_result [3:0]),
                              .tens(alu_result [7:4]),
                              .seg(SEG_num),
                              .AN(AN[1:0])
                              );
                      
       seg7_control ctrl_nibble(
                                .clk(clk_division),
                                .rst_n(reset_clean),
                                .control(SW[8:5]),
                                .seg(SEG_control),
                                .AN(AN[2])
                                );               
       
       assign LED[3:0] = tmp1; //shows the ones digit for the counter
       assign LED[7:4] = tmp2; //shows the tens digit for the counter
                                                                                                      
endmodule
