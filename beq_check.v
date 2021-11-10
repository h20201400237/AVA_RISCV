`timescale 1ns / 1ps

module beq_check(
    input [6:0] opcode,
input [31:0] R1 ,
input [31:0] R2 ,
output reg beq_select
    );
        // comparator unit for static branch prediction(Branch Not taken scheme)
    reg [31:0] R3 ;
    always @(R1,R2,opcode)
    begin
    if((opcode == 7'b1100111) && (R1 != R2))
    beq_select = 1'b1;
    else
    beq_select = 1'b0;
    end
endmodule
