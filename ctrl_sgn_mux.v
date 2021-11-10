`timescale 1ns / 1ps

module ctrl_sgn_mux(
input ctrl_sgnl_sel,
input If_Id_Reg_Write,
input [3:0] If_Id_acl,
input [1:0] If_Id_Output_Select,
input [1:0] If_Id_Read_Data_2_Sel,
input If_Id_MemWrite,
input If_Id_MemRead,
output reg If_c_Id_Reg_Write,
output reg [3:0] If_c_Id_acl,
output reg [1:0] If_c_Id_Output_Select,
output reg [1:0] If_c_Id_Read_Data_2_Sel,
output reg If_c_Id_MemWrite,
output reg If_c_Id_MemRead,
input beq_pc_Sel,
input If_id_flush,
output reg If_c_Id_beq_pc_Sel,
output reg If_c_id_flush
    );
    
      always @(*)
    begin
    // when no stalling required
    if (ctrl_sgnl_sel== 1'b1)
    begin
     If_c_Id_Reg_Write =If_Id_Reg_Write;
     If_c_Id_acl=If_Id_acl;
     If_c_Id_Output_Select=If_Id_Output_Select;
     If_c_Id_Read_Data_2_Sel=If_Id_Read_Data_2_Sel;
     If_c_Id_MemWrite=If_Id_MemWrite;
     If_c_Id_MemRead=If_Id_MemRead;
     If_c_Id_beq_pc_Sel =beq_pc_Sel;
     If_c_id_flush = If_id_flush;
     end
     // making the control signals zero when stalling is required
    else
    begin
    If_c_Id_Reg_Write =1'b0;
    If_c_Id_acl=4'b0000;
    If_c_Id_Output_Select=2'b00;
    If_c_Id_Read_Data_2_Sel=2'b00;
    If_c_Id_MemWrite=1'b0;
    If_c_Id_MemRead=1'b0;
    If_c_Id_beq_pc_Sel =1'b0;
    If_c_id_flush = 1'b0;
    end
    
    end
endmodule
