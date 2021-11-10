`timescale 1ns / 1ps

module shift_left_by_2(
    input [31:0] sign_Ex,
    output reg [31:0] sign_Ex_shift_by_2
    );
    
    // shift left block
    always @(sign_Ex)
    begin
    sign_Ex_shift_by_2 = (sign_Ex<<2);
    end
endmodule
