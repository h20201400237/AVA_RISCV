`timescale 1ns / 1ps

module address_cal(
input [31:0] PC,
input [31:0] sign_Ex_shift_by_2,
output reg [31:0] address 
    );
    
// address calculation for jump and branch
    always @ (*)
    begin
    address =PC + sign_Ex_shift_by_2;
    end
endmodule
