`timescale 1ns / 1ps
module Mux_mem_writedata(
    input [31:0] Mem_O_Wb_Mem_ReadData,
input [31:0] Mem_WriteData,
input Forward_Mem_To_Mem,
output reg [31:0] Mux_Mem_WriteData
    );
       // mem - to - mem forwarding data selection
     always @(*)
     begin
    if(Forward_Mem_To_Mem ==1'b1)
    Mux_Mem_WriteData =Mem_O_Wb_Mem_ReadData;
    else
    Mux_Mem_WriteData =Mem_WriteData;
    end
endmodule
