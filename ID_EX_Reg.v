`timescale 1ns / 1ps

module ID_EX_Reg(
   input clk,
input reset,
input [4:0] Id_In_Ex_Rs1,
input [4:0] Id_In_Ex_Rs2,
input Id_In_Ex_Reg_Write,
input [3:0] Id_In_Ex_acl,
input [1:0] Id_In_Ex_Output_Select,
input [4:0] Id_In_Ex_writereg,
input [31:0] Regfile_Read_Data_1,
input [31:0] Regfile_Read_Data_2,

output reg [4:0] Id_Out_Ex_Rs1,
output reg [4:0] Id_Out_Ex_Rs2,
output reg [31:0] ID_EX_Read_Data_1,
output reg [31:0] ID_EX_Read_Data_2,
output reg Id_Out_Ex_Reg_Write,
output reg [3:0] Id_Out_Ex_acl,
output reg [1:0] Id_Out_Ex_Output_Select,
output reg [4:0] Id_Out_Ex_writereg ,
input [31:0] Sign_Ex,
output reg [31:0] Id_0ut_Ex_Sign_Ex,
input Id_In_Ex_MemWrite,
input Id_In_Ex_MemRead,
output reg Id_O_Ex_MemWrite,
output reg Id_O_Ex_MemRead,
input [6:0] Id_In_opcode,
output reg [6:0] Id_O_Ex_opcode,
input [1:0] If_c_Id_Read_Data_2_Sel,
output reg [1:0] Id_Ex_Read_Data_2_Sel
    );
    
    reg c1,c2,c3;
        always @(posedge clk,negedge reset)
        begin
        if(reset == 0)
        begin
        ID_EX_Read_Data_1 = 32'h00000000;
        ID_EX_Read_Data_2 = 32'h00000000;
        Id_0ut_Ex_Sign_Ex = 32'h00000000;
        Id_Out_Ex_Rs1 = 5'b00000;
        Id_Out_Ex_Rs2 = 5'b00000;
        Id_Out_Ex_writereg =5'b00000;
        Id_Out_Ex_acl =4'b0000;
        Id_Out_Ex_Reg_Write =1'b0;
        Id_Out_Ex_Output_Select = 1'b0;
        Id_O_Ex_MemWrite = 1'b0;
        Id_O_Ex_MemRead =1'b0;
        Id_O_Ex_opcode = 7'b0000000;
        Id_Ex_Read_Data_2_Sel = 2'b00;
        end
        else
        begin
        ID_EX_Read_Data_1 = Regfile_Read_Data_1; 
        ID_EX_Read_Data_2 =  Regfile_Read_Data_2; 
        Id_Out_Ex_Reg_Write = Id_In_Ex_Reg_Write;
        Id_Out_Ex_acl =Id_In_Ex_acl;
        Id_Out_Ex_writereg =Id_In_Ex_writereg;
        Id_Out_Ex_Rs1 = Id_In_Ex_Rs1;
        Id_Out_Ex_Rs2 = Id_In_Ex_Rs2;
        Id_Out_Ex_Output_Select = Id_In_Ex_Output_Select;  
        Id_0ut_Ex_Sign_Ex = Sign_Ex;
        Id_O_Ex_MemWrite = Id_In_Ex_MemWrite;
        Id_O_Ex_MemRead =Id_In_Ex_MemRead;
        Id_O_Ex_opcode=Id_In_opcode;
        Id_Ex_Read_Data_2_Sel =If_c_Id_Read_Data_2_Sel;
        end
        end
endmodule
