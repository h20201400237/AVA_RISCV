`timescale 1ns / 1ps

module EX_MEM_Reg(
    input clk,
input reset,
input [4:0] Ex_In_Mem_Rs1,
input [4:0] Ex_In_Mem_Rs2,
input [4:0] Ex_In_Mem_Rd,
input [31:0] Ex_In_Aluresult,
input Ex_In_Mem_Reg_Write,
input [1:0] Ex_In_Mem_Output_Select,
output reg [4:0] Ex_Out_Mem_Rs1,
output reg [4:0] Ex_Out_Mem_Rs2,
output reg [4:0] Ex_Out_Mem_Rd,
output reg [31:0] Ex_Out_Aluresult,
output reg Ex_Out_Mem_Reg_Write,
output reg [1:0] Ex_Out_Mem_Output_Select,
input Ex_In_Mem_MemWrite,
input Ex_In_Mem_MemRead,
output reg Ex_O_Mem_MemWrite,
output reg Ex_O_Mem_MemRead,
input [31:0] Ex_In_Mem_ReadData2,
output reg [31:0] Ex_Out_Mem_ReadData2
    );
    
    always @(posedge clk,negedge reset)
           begin
           if(reset == 0)
           begin
           Ex_Out_Mem_Rs1 = 5'b00000;
           Ex_Out_Mem_Rs2 = 5'b00000;
           Ex_Out_Mem_Rd = 5'b00000;
           Ex_Out_Aluresult = 32'h0000;
           Ex_Out_Mem_Reg_Write = 1'b0;
           Ex_Out_Mem_Output_Select = 2'b00;
           Ex_O_Mem_MemWrite =2'b0;
           Ex_O_Mem_MemRead= 2'b0;
           Ex_Out_Mem_ReadData2 = 32'h0000;
           end
           else
           begin
           Ex_Out_Mem_Rs1 =Ex_In_Mem_Rs1;
           Ex_Out_Mem_Rs2 =Ex_In_Mem_Rs2;
           Ex_Out_Mem_Rd=Ex_In_Mem_Rd;
           Ex_Out_Aluresult=Ex_In_Aluresult;
           Ex_Out_Mem_Reg_Write = Ex_In_Mem_Reg_Write;
           Ex_Out_Mem_Output_Select = Ex_In_Mem_Output_Select;
           Ex_O_Mem_MemWrite =Ex_In_Mem_MemWrite;
           Ex_O_Mem_MemRead=Ex_In_Mem_MemRead;
           Ex_Out_Mem_ReadData2 = Ex_In_Mem_ReadData2;
           end
           end
endmodule
