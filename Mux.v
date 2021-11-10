`timescale 1ns / 1ps

module Mux(
input [31:0] a,
input [31:0] b,
input [31:0] c,
input [1:0] select_line,
output reg [31:0] mux_output
    );
    
    always @(a,b,select_line)
    begin
    if(select_line ==2'b10 )
    mux_output = c;
    else if(select_line ==2'b01 )
    mux_output = b;
    else
    mux_output = a;
    end
endmodule
