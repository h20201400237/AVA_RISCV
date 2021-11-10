`timescale 1ns / 1ps

module MEM_WB_Reg(
input clk,
input reset,
input [4:0] Mem_In_Wb_Rs1,
input [4:0] Mem_In_Wb_Rs2,
input [4:0] Mem_In_Wb_Rd,
input [31:0] Mem_In_Wb_Aluresult,
input Mem_In_Wb_Reg_Write,
input [1:0] Mem_In_Wb_Output_Select,
output reg [4:0] Mem_Out_Wb_Rs1,
output reg [4:0] Mem_Out_Wb_Rs2,
output reg [4:0] Mem_Out_Wb_Rd,
output reg [31:0] Mem_Out_Wb_Aluresult,
output reg Mem_Out_Wb_Reg_Write,
output reg [1:0] Mem_Out_Wb_Output_Select,
input Mem_In_Wb_MemRead,
output reg Mem_0_Wb_MemRead,
input [31:0] Mem_In_Wb_MemRead_Data,
output reg [31:0] Mem_O_Wb_MemRead_Data
    );
    
     always @(posedge clk,negedge reset)
              begin
              if(reset == 0)
              begin
              Mem_Out_Wb_Rs1 = 5'b00000;
              Mem_Out_Wb_Rs2 = 5'b00000;
              Mem_Out_Wb_Rd = 5'b00000;
              Mem_Out_Wb_Aluresult = 32'h0000;
              Mem_Out_Wb_Reg_Write = 1'b0;
              Mem_Out_Wb_Output_Select = 2'b00;
              Mem_0_Wb_MemRead = 1'b0;
              Mem_O_Wb_MemRead_Data = 32'h0000;
              end
              else
              begin
              Mem_Out_Wb_Rs1 =Mem_In_Wb_Rs1;
              Mem_Out_Wb_Rs2 =Mem_In_Wb_Rs2;
              Mem_Out_Wb_Rd=Mem_In_Wb_Rd;
              Mem_Out_Wb_Aluresult=Mem_In_Wb_Aluresult;
              Mem_Out_Wb_Reg_Write = Mem_In_Wb_Reg_Write;
              Mem_Out_Wb_Output_Select = Mem_In_Wb_Output_Select;
              Mem_0_Wb_MemRead =Mem_In_Wb_MemRead;
              Mem_O_Wb_MemRead_Data =Mem_In_Wb_MemRead_Data;
              end
              end
endmodule
