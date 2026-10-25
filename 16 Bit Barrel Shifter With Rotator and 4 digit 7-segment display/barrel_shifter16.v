`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 05:41:34 PM
// Design Name: 
// Module Name: barrel_shifter16
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


module barrel_shifter16(
                        input [15:0] data_in,
                        input [3:0] shamt,
                        input dir,
                        input rotate,
                        output [15:0] data_out
                        );
                        
        wire [15:0] stage0, stage1, stage2, stage3;
    
        // Stage 0: shift/rotate by 1 if shamt[0] is set
        barrel_stage #(.AMOUNT(1)) s0 (
                                        .data_in(data_in), 
                                        .dir(dir), 
                                        .rotate(rotate),
                                        .enable(shamt[0]), 
                                        .data_out(stage0)
                                      );
    
        // Stage 1: shift/rotate by 2 if shamt[1] is set
        barrel_stage #(.AMOUNT(2)) s1 (
                                        .data_in(stage0), 
                                        .dir(dir),
                                        .rotate(rotate),
                                        .enable(shamt[1]), 
                                        .data_out(stage1)
                                      );
                                
        // Stage 2: shift/rotate by 4 if shamt[2] is set
        barrel_stage #(.AMOUNT(4)) s2 (
                                        .data_in(stage1), 
                                        .dir(dir), 
                                        .rotate(rotate),
                                        .enable(shamt[2]), 
                                        .data_out(stage2)
                                      );
    
        // Stage 3: shift/rotate by 8 if shamt[3] is set
        barrel_stage #(.AMOUNT(8)) s3 (
                                        .data_in(stage2), 
                                        .dir(dir), 
                                        .rotate(rotate),
                                        .enable(shamt[3]), 
                                        .data_out(stage3)
                                      );
    
        assign data_out = stage3;                 
endmodule
