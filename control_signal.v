`timescale 1ns / 1ps

module control_signal(
     input [31:0] instructioncode,
input beq_pc,
input If_Id_Write,                         // IF/ID stop clocking 
output reg If_Id_Reg_Write,                // IF/ID.Reg_Write
output reg [3:0] If_Id_acl,                // IF/ID.ALU control_op
output reg [1:0] If_Id_Output_Select,      // IF/ID.regtoMem
output reg [1:0] If_Id_Read_Data_2_Sel,    // IF/ID.ALUsrc
output reg If_Id_MemWrite,                 // IF/ID.MemWrite
output reg If_Id_MemRead,                  // IF/ID.MemRead
output reg beq_pc_sel,                     
output reg If_id_flush
    );
    
    always @(instructioncode,beq_pc,If_Id_Write)
        begin
        // r-type instructions
        if(instructioncode[6:0]==7'b0110011)
        begin
        
                If_Id_Reg_Write =1'b1;
                If_Id_Output_Select=2'b01;              
                If_Id_Read_Data_2_Sel = 2'b01;          
                If_Id_MemWrite =1'b0;
                If_Id_MemRead =1'b0;
                beq_pc_sel = 1'b0;
                If_id_flush = 1'b0;
                if(instructioncode[31:25]==7'b0000000)  // Funct7 => instructioncode[31:25]  and  Funct3 => instructioncode[14:12]
                begin
                     // for add instruction
                   if(instructioncode[14:12]==3'b000)
                      begin
                      If_Id_acl=4'b0000;
                      end
                      // for sll instruction
                   else if(instructioncode[14:12]==3'b001)
                      begin
                      If_Id_acl=4'b0010;
                      end
                      // for slt instruction
                   else if(instructioncode[14:12]==3'b010)
                      begin
                      If_Id_acl=4'b0011;
                      end
                      // for xor instruction
                   else if(instructioncode[14:12]==3'b100)
                      begin
                      If_Id_acl=4'b0100;
                      end
                      // for srl instruction
                   else if(instructioncode[14:12]==3'b101)
                      begin
                      If_Id_acl=4'b0101;
                      end
                      // for or instruction
                   else if(instructioncode[14:12]==3'b110)
                      begin
                      If_Id_acl=4'b0110;
                      end
                      // for and instruction
                   else if(instructioncode[14:12]==3'b111)
                      begin
                      If_Id_acl=4'b0111;
                      end
                end
                
             else if(instructioncode[31:25]==7'b0100000)
             begin
             // for sub instruction
                 if(instructioncode[14:12]==3'b000)
                 begin
                 If_Id_acl=4'b0001;
    
                 end
             end
          end   
          // for i-type instructions
          else if (instructioncode[6:0]==7'b0010011)
          begin
          If_id_flush = 1'b0;
          beq_pc_sel = 1'b0;
          If_Id_Reg_Write =1'b1;
          If_Id_Output_Select=2'b01;
          If_Id_Read_Data_2_Sel = 2'b10;
          If_Id_MemWrite =1'b0;
          If_Id_MemRead =1'b0;
                            // for addi instruction
                           if(instructioncode[14:12]==3'b000)
                            begin
                            If_Id_acl=4'b0000;
                            end
                            // for slti instruction
                         else if(instructioncode[14:12]==3'b010)
                            begin
                            If_Id_acl=4'b0011;
                            end
                            // for xori instruction
                         else if(instructioncode[14:12]==3'b100)
                            begin
                            If_Id_acl=4'b0100;
                            end
                            // for ori instruction
                         else if(instructioncode[14:12]==3'b110)
                            begin
                            If_Id_acl=4'b0110;
                            end
                            //// for andi instruction
                         else if(instructioncode[14:12]==3'b111)
                            begin
                            If_Id_acl=4'b0111;
                            end
            end
            // for store instruction
            else if (instructioncode[6:0]==7'b0100011)
            begin
            If_id_flush = 1'b0;
            beq_pc_sel = 1'b0;
            If_Id_Reg_Write =1'b0;
            If_Id_Output_Select=2'bXX;
            If_Id_Read_Data_2_Sel = 2'b10;
            If_Id_MemWrite =1'b1;
            If_Id_MemRead =1'b0;
            If_Id_acl=4'b0000;
            end
            // for load instruction
            else if (instructioncode[6:0]==7'b0000011)
            begin
            If_id_flush = 1'b0;
            beq_pc_sel = 1'b0;
            If_Id_Reg_Write =1'b1;
            If_Id_Output_Select=2'b10;
            If_Id_Read_Data_2_Sel = 2'b10;
            If_Id_MemWrite =1'b0;
            If_Id_MemRead =1'b1;
            If_Id_acl=4'b0000;
            end
            // for branch instruction(Branch not taken scheme)
            else if (instructioncode[6:0]==7'b1100111)
            begin
            // considering the stalling cases 
            if(beq_pc==1'b1 && If_Id_Write == 1'b1)
            begin
            beq_pc_sel = 1'b1;
            If_id_flush = 1'b1;
            end
            else
            begin
            beq_pc_sel = 1'b0;
            If_id_flush = 1'b0;
            end
           
            
            If_Id_Reg_Write =1'b0;
            If_Id_Output_Select=2'bXX;
            If_Id_Read_Data_2_Sel = 2'b01;
            If_Id_MemWrite =1'b0;
            If_Id_MemRead =1'b0;
            If_Id_acl=4'b0001;
            end
            // for jump instruction
            else if (instructioncode[6:0]==7'b1101111)
            begin
            If_id_flush = 1'b0;
            beq_pc_sel = 1'b0;
            If_Id_Reg_Write =1'b0;
            If_Id_Output_Select=2'bXX;
            If_Id_Read_Data_2_Sel = 2'bXX;
            If_Id_MemWrite =1'b0;
            If_Id_MemRead =1'b0;
            If_Id_acl=4'bXXXX;
            end
            // to give a duplicate instruction
            else if (instructioncode[6:0]==7'b0000000)
            begin
            If_id_flush = 1'bx;
            beq_pc_sel = 1'bx;
            If_Id_Reg_Write =1'bx;
            If_Id_Output_Select=2'bxx;
            If_Id_Read_Data_2_Sel = 2'bxx;
            If_Id_MemWrite =1'bx;
            If_Id_MemRead =1'bx;
            If_Id_acl=4'bXXXX;
            end
         
         end
endmodule
