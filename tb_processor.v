`timescale 1ns / 1ps

module tb_processor(

    );
        reg clk;
    reg reset;
    wire [31:0]p_o;
    Processor p(clk,reset,p_o);
    initial begin
    clk=1;
    repeat(50)
        #5 clk=~(clk);
    
    end
    initial begin
    reset=0;
    #5 reset=1;
   // #2 reset=1;
    end
endmodule
