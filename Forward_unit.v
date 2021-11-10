`timescale 1ns / 1ps
module Forward_unit(
    input Mem_0_Wb_MemRead,             // MEM/WB.Memread
input Ex_Out_Mem_Reg_Write,             // EX/MEM.Regwrite
input [4:0] Ex_Out_Mem_writereg,        // EX/MEM.RegisterRd
input Mem_Out_Wb_Reg_Write,             // MEM/WB.Regwrite
input [4:0] Mem_Out_Wb_writereg,        // MEM/WB.RegisterRd
input [4:0] Id_Out_Ex_Rs1,              // ID/EX.rs1
input [4:0] Id_Out_Ex_Rs2,              // ID/EX.rs2
input Id_O_Ex_MemWrite,                 // ID/EX.Memwrite
input [6:0] Id_O_Ex_opcode,             // ID/EX.Opcode
output reg [1:0] Forward_Rs1,
output reg [1:0] Forward_Rs2,
output reg [1:0] Forward_Rs1_to_Id,
output reg [1:0] Forward_Rs2_to_Id,
input Ex_O_Mem_MemWrite,                // EX/MEM.Memwrite
input [4:0] Ex_O_Mem_Rs2,
output reg Fwd_Mem_to_Mem
    );
    
     always @(*)
           begin
           // ex to ex forwarding
           if( (Ex_Out_Mem_Reg_Write ==1)&(Ex_Out_Mem_writereg!=3'b000)&(Ex_Out_Mem_writereg==Id_Out_Ex_Rs1))
           Forward_Rs1 =2'b01 ;
           // mem to ex forwarind
           else if ((Mem_Out_Wb_Reg_Write ==1)&(Mem_Out_Wb_writereg!=3'b000)&(Mem_Out_Wb_writereg==Id_Out_Ex_Rs1))
           Forward_Rs1 =2'b10 ;
          // when forwarding is not required 
           else 
           Forward_Rs1 =2'b00;
           
           // ex to ex forwarding
           if( (Ex_Out_Mem_Reg_Write ==1)&(Ex_Out_Mem_writereg!=3'b000)&(Ex_Out_Mem_writereg==Id_Out_Ex_Rs2)&(Id_O_Ex_opcode != 7'b0010011))
           Forward_Rs2 =2'b01 ;
           // mem to ex forwarding
           else if ((Mem_Out_Wb_Reg_Write ==1)&(Mem_Out_Wb_writereg!=3'b000)&(Mem_Out_Wb_writereg==Id_Out_Ex_Rs2)&(Id_O_Ex_opcode != 7'b0010011))
           Forward_Rs2 =2'b10 ;
            // when forwarding is not required 
           else 
           Forward_Rs2 =2'b00;
           
            // ex to id forwarding
            if  (Id_O_Ex_opcode == 7'b1100011 &Ex_Out_Mem_Reg_Write == 1'b1 & Ex_Out_Mem_writereg==Id_Out_Ex_Rs1 &Ex_Out_Mem_writereg!=5'b00000 )
            Forward_Rs1_to_Id = 2'b01;
            // mem to id forwarding
            else if (Id_O_Ex_opcode == 7'b1100011 &Mem_Out_Wb_Reg_Write == 1'b1 & Mem_Out_Wb_writereg==Id_Out_Ex_Rs1 &Mem_Out_Wb_writereg!=5'b00000 ) 
            Forward_Rs1_to_Id = 2'b10;
            // when no forarding is required
            else
            Forward_Rs1_to_Id = 2'b00;
            
            // ex to id forwarding
             if  (Id_O_Ex_opcode == 7'b1100011 &Ex_Out_Mem_Reg_Write == 1'b1 & Ex_Out_Mem_writereg==Id_Out_Ex_Rs2 &Ex_Out_Mem_writereg!=5'b00000 )
             Forward_Rs2_to_Id = 2'b01;
             // mem to id forwarding
             else if (Id_O_Ex_opcode == 7'b1100011 &Mem_Out_Wb_Reg_Write == 1'b1 & Mem_Out_Wb_writereg==Id_Out_Ex_Rs2 &Mem_Out_Wb_writereg!=5'b00000 ) 
             Forward_Rs2_to_Id = 2'b10;
             // when no forarding is required
             else
             Forward_Rs2_to_Id = 2'b00;
           
               // mem to mem forwarding
             if((Mem_0_Wb_MemRead ==1'b1) & (Ex_O_Mem_MemWrite==1'b1) & (Mem_Out_Wb_writereg == Ex_O_Mem_Rs2) & (Mem_Out_Wb_writereg != 5'b00000))
             Fwd_Mem_to_Mem = 1'b1;
             else
             Fwd_Mem_to_Mem = 1'b0;
   
           
           end
endmodule
