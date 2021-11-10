`timescale 1ns / 1ps

module PC_increment(
    
    input [31:0] PC,
    output reg [31:0] PC_Incremented
    
    );
    
    always @(PC)
    begin
    PC_Incremented = PC+4 ;
    end
        
endmodule
