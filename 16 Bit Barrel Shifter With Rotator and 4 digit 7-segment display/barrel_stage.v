`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 06:02:12 PM
// Design Name: 
// Module Name: barrel_stage
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


module barrel_stage #(parameter AMOUNT = 1) (
                                                input [15:0] data_in,
                                                input dir,
                                                input rotate,
                                                input enable,
                                                output [15:0] data_out
                                            );

            wire [15:0] shifted;
        
            assign shifted = dir ?
                // shift/rotate RIGHT by AMOUNT
                (rotate ? {data_in[AMOUNT-1:0], data_in[15:AMOUNT]}      // rotate right
                        : {{AMOUNT{1'b0}}, data_in[15:AMOUNT]})           // logical shift right
                :
                // shift/rotate LEFT by AMOUNT
                (rotate ? {data_in[15-AMOUNT:0], data_in[15:16-AMOUNT]}  // rotate left
                        : {data_in[15-AMOUNT:0], {AMOUNT{1'b0}}});        // logical shift left
        
            genvar i;
            generate
                for (i = 0; i < 16; i = i + 1) begin : mux_bit
                    assign data_out[i] = enable ? shifted[i] : data_in[i];
                end
            endgenerate
        
endmodule
