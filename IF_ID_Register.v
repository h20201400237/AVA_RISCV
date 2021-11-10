`timescale 1ns / 1ps

module IF_ID_Register(
input clk,
input reset,
input If_id_flush,
input If_Id_Write,                           // Used to stop CLK for IF/ID Reg
input [31:0] instructioncode,
output reg [4:0] If_Id_Rs2,
output reg [4:0] If_Id_Rs1,
output reg [4:0] If_Id_Rd,
output reg [31:0] If_Id_instructioncode,
input [31:0] PC,
output reg [31:0] If_Id_Pc
    );
    
     always @(posedge clk,negedge reset, negedge If_Id_Write)
      begin
      // To flush the register 
      if(reset == 0 |If_id_flush == 1)
      begin
      If_Id_Rd = 5'b00000;
      If_Id_Rs1 = 5'b00000;
      If_Id_Rs2 = 5'b00000;
      If_Id_instructioncode = 32'h00000000;
      If_Id_Pc = 32'h00000000;
   
      end
      // To stall the if id register
      else if(If_Id_Write == 1'b0)
    
      begin
       If_Id_Rd =If_Id_Rd;
       If_Id_Rs1 =If_Id_Rs1;
       If_Id_Rs2 =If_Id_Rs2 ;
       If_Id_instructioncode = If_Id_instructioncode;
       If_Id_Pc =If_Id_Pc;
   
      end
      
      else
   
      begin
      If_Id_Rd =instructioncode[11:7]; 
      If_Id_Rs1 =instructioncode[19:15]; 
      If_Id_Rs2 =instructioncode[24:20]; 
      If_Id_instructioncode = instructioncode;
      If_Id_Pc =PC;
      end
   
      
      
      end
endmodule
