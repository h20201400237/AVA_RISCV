`timescale 1ns / 1ps
module stalling_unit(
   input Ex_O_Mem_Reg_Write,
input Ex_O_Mem_MemRead,
input [4:0] Ex_O_Mem_Rd,
input Id_O_Ex_MemRead,
input Id_O_Ex_Reg_Write,
input [4:0] Id_Out_Ex_Rd,
input [4:0] Id_Out_Ex_Rs2, 
input [4:0] If_Id_Rs2,
input [4:0] If_Id_Rs1,
input [6:0] opcocde,
input [6:0] Id_O_Ex_opcode,
output reg Pc_Write,             // To stop PC clocking
output reg If_Id_Write,          // To stop IF/ID reg clocking
output reg control_sel           // To make control signals zero 
    );
    
     reg c1,c2,c3,c4,c5;
    always @(*)
    begin
    // covering the cases of stalling for load and store store instructions
    c1= ((Id_O_Ex_MemRead==1'b1)&(Id_Out_Ex_Rd !=5'b00000)& ((Id_Out_Ex_Rd ==If_Id_Rs2) | (Id_Out_Ex_Rd ==If_Id_Rs1)));  //load handling
    c2 =((opcocde == 7'b0100011)&(Id_Out_Ex_Rd ==If_Id_Rs2)&(Id_Out_Ex_Rd !=If_Id_Rs1));                                 //store handling
   // rtype - branch stalling conditions c3 and c4
    c3 =((Id_O_Ex_Reg_Write==1'b1)&(opcocde == 7'b1100011)&(Id_Out_Ex_Rd !=5'b00000)& ((Id_Out_Ex_Rd ==If_Id_Rs2) | (Id_Out_Ex_Rd ==If_Id_Rs1)));
    c4 = ((Ex_O_Mem_Reg_Write==1'b1)&(opcocde == 7'b1100011)&(Ex_O_Mem_Rd !=5'b00000)& (Id_O_Ex_opcode!= 7'b1100011) &((Ex_O_Mem_Rd ==If_Id_Rs2) | (Ex_O_Mem_Rd ==If_Id_Rs1)));
    // load- branch stalling condition
    c5 = ((Ex_O_Mem_MemRead==1'b1)&(opcocde == 7'b1100011)&(Ex_O_Mem_Rd !=5'b00000)& ((Ex_O_Mem_Rd ==If_Id_Rs2) | (Ex_O_Mem_Rd ==If_Id_Rs1)));
    
   if( ((c1&(~c2))|c3|c4|c5)==1'b1)
   // stalling PC and IF/ID 
   // Control signal to make control signals zero
   begin
   Pc_Write = 1'b0;
   If_Id_Write= 1'b0;
   control_sel =1'b0;
   end
   
   else
   begin
   Pc_Write = 1'b1;
   If_Id_Write= 1'b1;
   control_sel =1'b1;
   end
   
   end   
endmodule
