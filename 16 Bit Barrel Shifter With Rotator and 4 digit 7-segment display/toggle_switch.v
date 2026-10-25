`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2026 12:38:55 PM
// Design Name: 
// Module Name: toggle_switch
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


module toggle_switch(
                    input clk_1khz,
                    input rst,
                    input btn_raw,
                    output reg btn_toggle
                    );
                    
             wire btn_clean;
             reg btn_prev;
       
       debounce db (
                    .clk(clk_1khz),
                    .btn_in(btn_raw),
                    .btn_clean(btn_clean)
                    );
                    
       always@(posedge clk_1khz or posedge rst)
        begin
            if(rst)
                begin
                    btn_toggle <= 0;
                    btn_prev <= 0;
                end
            else 
                begin
                    if(btn_clean && !btn_prev)
                        btn_toggle <= ~btn_toggle;
                    btn_prev <= btn_clean;    
                end    
        end                         
endmodule
