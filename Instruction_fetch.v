`timescale 1ns / 1ps

module Instruction_fetch(
    
    input rst,
    input [31:0]PC,
    output [31:0]instr_code
    );
    
    instruction_mem I0(rst, PC, instr_code);
    
    
endmodule
