`timescale 1ns / 1ps

module jump_sel_address(
    input [6:0] opcode,
    output reg jump_pc_sel
    );
    // To select the jump address 
    // JUMP selection input for jump address in PC
    always @(opcode)
    begin
    if(opcode == 7'b1101111)
    jump_pc_sel = 1;
    else
    jump_pc_sel= 0;
    
    end
endmodule
