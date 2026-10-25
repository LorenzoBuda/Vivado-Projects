`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2026 12:47:13 PM
// Design Name: 
// Module Name: top_lab7
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


module top_lab7 (
                    input clk,   
                    input rst_n,       // resets
                    input btnc,         //increments shamt [3:2]
                    input btnu,         // toggles dir
                    input btnd,         // toggles rotate
                    input btnl,         // toggles shamt[0]
                    input btnr,         // toggles shamt[1]
                    
                    input wire [15:0] SW, 
                    output wire [7:0] LED,
                    output wire [7:0] AN,
                    output wire [6:0] SEG
                );

    wire clk_1khz, clk_2hz;
    wire rst = ~rst_n;

    clock_divider_fixed u_clkdiv (
                                    .clk_100mhz(clk),
                                    .rst(rst),
                                    .clk_1khz(clk_1khz),
                                    .clk_2hz(clk_2hz)
                                 );
                            
    wire dir, rotate, shamt0, shamt1, btnc_toggle;

    toggle_switch db_dir (
                            .clk_1khz(clk_1khz), 
                            .rst(rst), 
                            .btn_raw(btnu), 
                            .btn_toggle(dir)
                            );
    toggle_switch db_rot (
                            .clk_1khz(clk_1khz), 
                            .rst(rst), 
                            .btn_raw(btnd), 
                            .btn_toggle(rotate)
                            );
    toggle_switch db_s0  (
                            .clk_1khz(clk_1khz), 
                            .rst(rst), 
                            .btn_raw(btnl), 
                            .btn_toggle(shamt0)
                            );
    toggle_switch db_s1  (
                            .clk_1khz(clk_1khz), 
                            .rst(rst), 
                            .btn_raw(btnr), 
                            .btn_toggle(shamt1)
                            );
                            
    toggle_switch db_btnc (
                            .clk_1khz(clk_1khz), 
                            .rst(rst), 
                            .btn_raw(btnc), 
                            .btn_toggle(btnc_toggle)
                          );

    reg btnc_prev;

    always @(posedge clk_1khz or posedge rst) // produces a pulse to feed into shamt_counter module
        begin
            if (rst) 
                begin
                    btnc_prev  <= 1'b0;
                end 
            else 
                begin
                    btnc_prev <= btnc_toggle;

                end
        end

    wire btnc_pulse = btnc_toggle ^ btnc_prev;  // 1-cycle pulse on each press

    wire [1:0] shamt_hi;
    
    shamt_counter shamt_cnt (
                                .clk_1khz(clk_1khz),
                                .rst(rst),
                                .btnc_pressed_edge(btnc_pulse),
                                .count(shamt_hi)
                               );

    wire [3:0] shamt = {shamt_hi, shamt1, shamt0};

    wire [15:0] result_word;

    barrel_shifter16 u_shifter (
                                .data_in(SW),
                                .shamt(shamt),
                                .dir(dir),
                                .rotate(rotate),
                                .data_out(result_word)
                                );

    seg7_scan8 u_scan (
                        .clk_1khz(clk_1khz),
                        .rst(rst),
                        .data_in(result_word),
                        .an(AN),
                        .seg(SEG)
                      );

    assign LED[0] = dir;
    assign LED[1] = rotate;
    assign LED[5:2] = shamt;
    assign LED[7:6] = 2'b00;

endmodule