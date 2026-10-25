`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2026 06:52:10 PM
// Design Name: 
// Module Name: load_fsm
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


module load_fsm(
                input clk,
                input rst_n,
                input load_pulse,
                output reg [1:0] slot,
                output wire [3:0] slot_onehot,
                output reg wr_res, wr_r, wr_g, wr_b
                );
                
       assign slot_onehot = 4'b0001 << slot;
       
        always @(posedge clk or negedge rst_n) 
            begin
                if (!rst_n)
                    begin 
                        slot <= 2'd0;
                    end
                else if (load_pulse)
                    begin 
                        slot <= slot + 2'd1;
                    end
            end
            
        always @(*) 
            begin
                wr_res = 0; 
                wr_r = 0; 
                wr_g = 0; 
                wr_b = 0;
                    case (slot)
                        2'd0: wr_res = load_pulse;
                        2'd1: wr_r = load_pulse;
                        2'd2: wr_g = load_pulse;
                        2'd3: wr_b = load_pulse;
                    endcase
            end         
endmodule
