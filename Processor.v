    `timescale 1ns / 1ps
    module Processor(input clk,input reset,output [31:0] p_o);
       wire [31:0] PC_Sel,jump_address,jump_offset,jump_sign_Ex,beq_Read_Data_1,beq_Read_Data_2,sign_Ex_shift_by_2,inst_code,PC,PC_Inc,jumpaddress,If_Id_inst_code,
	   WriteData,Read_Data_1,Read_Data_2,aluresult,a,b,ID_EX_Read_Data_1,ID_EX_Read_Data_2,Ex_O_Aluresult;    
       wire [31:0] Mem_O_Wb_PC_Inc, Ex_O_Mem_PC_Inc;
       wire [31:0] Id_O_Ex_PC_Inc,If_Id_PC_Inc,If_Id_PC,branch_address,Mem_O_Wb_Aluresult,Alu_Input_2,Alu_Input_1,signextended_output,processor_output,sign_Ex,
	   Id_0_Ex_Sign_Ex,Mux_selected_read_Data;
       wire [31:0] Mem_WriteData,Mem_ReadData,Mem_O_Wb_Mem_ReadData,Mux_Mem_WriteData;
       wire [4:0] If_Id_Rs2,If_Id_Rs1,If_Id_Rd,Id_Out_Ex_Rs1,Id_Out_Ex_Rs2,Id_O_Ex_Rd,Ex_O_Mem_Rs1,Ex_O_Mem_Rs2,Ex_O_Mem_Rd,Mem_O_Wb_Rs1,Mem_O_Wb_Rs2,Mem_O_Wb_Rd;
       wire [3:0] If_Id_acl,Id_O_Ex_acl,If_c_Id_acl;
       wire [1:0] Forward_Rs1_to_Id,Forward_Rs2_to_Id,Ex_to_Id_Fwd_R1,Ex_to_Id_Fwd_R2,If_Id_Output_Select,Id_O_Ex_Output_Select,If_c_Id_Output_Select,Ex_O_Mem_Output_Select,
	   Mem_O_Wb_Output_Select,Forward_Rs1,Forward_Rs2,If_Id_Read_Data_2_Sel,If_c_Id_Read_Data_2_Sel,Id_Ex_Read_Data_2_Sel;
       wire RegWrite,If_Id_Reg_Write,Zero,Id_O_Ex_Reg_Write,Ex_O_Mem_Reg_Write,Mem_O_Wb_Reg_Write,If_Id_MemWrite,If_Id_MemRead,Id_O_Ex_MemWrite,
	   Id_O_Ex_MemRead,If_c_Id_beq_pc_Sel,If_c_id_flush;
       wire jump_sel,If_id_flush,beq_pc,beq_pc_sel,Fwd_Mem_to_Mem,Ex_O_Mem_MemWrite,Ex_O_Mem_MemRead,Mem_0_Wb_MemRead,Pc_Write,If_Id_Write,control_sel,
	   If_c_Id_Reg_Write,If_c_Id_MemWrite,If_c_Id_MemRead,If_O_Id_Write;
       wire [6:0] opcode_sel,Id_O_Ex_opcode;
       
	   // ************************************************************ IF stage ****************************************************************************
	   
       // Pc increment block(PC_Inc = PC+4)
       PC_increment Pc_A(PC,PC_Inc);
       // To generate the jump selection signal for PC(I/P --> Opcode , O/P --> MUX control signal to chose between 'PC+4' & 'PC+4+X')
       jump_sel_address J_sel(inst_code[6:0],jump_sel); 
       // PC selection block (O/P --> PC,chosen based on instruction type)
       PC_select pc_mux(clk,reset,Pc_Write,If_c_Id_beq_pc_Sel,jump_sel,jump_address,branch_address,PC_Inc,PC);
       // Instruction Fetch block(O/P --> inst_code[32])
       Instruction_fetch IF(reset,PC,inst_code);
       // Sign extension block - To calculate jump offset(O/P --> jump_sign_EX(32 bit sign extended value) )
       sign_extented j_s(inst_code[6:0],inst_code,jump_sign_Ex); 
       // shift left by 2 -- for jump offset(O/P --> jump_offset(Left shifted sign extended value) )
       shift_left_by_2 j_sll(jump_sign_Ex,jump_offset);
       // Adding the PC to jump offset to calculate jump address( O/P --> jump_address)
       address_cal jump_addr(PC,jump_offset,jump_address);
	   
	   
       // IF/ID pipeline register
       IF_ID_Register If_id(clk,reset,If_c_id_flush,If_Id_Write,inst_code,If_Id_Rs2,If_Id_Rs1,If_Id_Rd,If_Id_inst_code,PC,If_Id_PC);
	   
	   // ************************************************************ ID stage ****************************************************************************
	   
       // Sign extension block - To calculate branch offset 
       sign_extented s1(If_Id_inst_code[6:0],If_Id_inst_code,sign_Ex); 
       // shift left by 2 -- for branch offset
       shift_left_by_2 s11(sign_Ex,sign_Ex_shift_by_2);
       // Adding the IF ID PC to branch offset to calculate branching address
       address_cal beq_addr(If_Id_PC,sign_Ex_shift_by_2,branch_address);
       // Register File ( O/P --> Read_Data_1,Read_Data_2)
       Register_file R1(If_Id_Rs1,If_Id_Rs2,Mem_O_Wb_Rd,reset,Mem_O_Wb_Reg_Write,processor_output,Read_Data_1,Read_Data_2);
	   //*****************                      Resolving Branch Hazard                  ********************
       // Input 1 selection to the comparator(O/P --> beq_Read_Data_1(Used as I/P for beq_check module)
       Mux beq_R1(Read_Data_1,Ex_O_Aluresult,processor_output,Forward_Rs1_to_Id,beq_Read_Data_1);
       // Input 1 selection to the comparator(O/P --> beq_Read_Data_2(Used as I/P for beq_check module)
       Mux beq_R2(Read_Data_2,Ex_O_Aluresult,processor_output,Forward_Rs2_to_Id,beq_Read_Data_2);
       // comparator for branching instructions - static branch prediction(O/P --> beq_pc( Control signal for chosing branch MUX) ) 
       beq_check b_c(If_Id_inst_code[6:0],beq_Read_Data_1,beq_Read_Data_2,beq_pc);
	   
	   //*****************                      Control signal generation                  ********************
	   
	   // O/P signals --> IF/ID.Reg_Write , IF/ID.ALU control_op , IF/ID.regtoMem , IF/ID.ALUsrc , IF/ID.MemWrite , IF/ID.MemRead , IF/ID.flush 
       // Control unit
       control_signal C1(If_Id_inst_code,beq_pc,If_Id_Write,If_Id_Reg_Write,If_Id_acl,If_Id_Output_Select,If_Id_Read_Data_2_Sel,If_Id_MemWrite,If_Id_MemRead,beq_pc_sel,If_id_flush);
       // Control signal mux -- for stalling cases to make control signals zero
       ctrl_sgn_mux c1_mux(control_sel,If_Id_Reg_Write,If_Id_acl,If_Id_Output_Select,If_Id_Read_Data_2_Sel,If_Id_MemWrite,If_Id_MemRead,If_c_Id_Reg_Write,If_c_Id_acl,
	   If_c_Id_Output_Select,If_c_Id_Read_Data_2_Sel,If_c_Id_MemWrite,If_c_Id_MemRead,beq_pc_sel,If_id_flush,If_c_Id_beq_pc_Sel,If_c_id_flush);
       
	   // ID/EX pipeline register
       ID_EX_Reg Id_Ex(clk,reset,If_Id_Rs1,If_Id_Rs2,If_c_Id_Reg_Write,If_c_Id_acl,If_c_Id_Output_Select,If_Id_Rd,Read_Data_1,Read_Data_2,Id_Out_Ex_Rs1,
	   Id_Out_Ex_Rs2,ID_EX_Read_Data_1,ID_EX_Read_Data_2,Id_O_Ex_Reg_Write,Id_O_Ex_acl,Id_O_Ex_Output_Select,Id_O_Ex_Rd,sign_Ex,Id_0_Ex_Sign_Ex,
	   If_c_Id_MemWrite,If_c_Id_MemRead,Id_O_Ex_MemWrite,Id_O_Ex_MemRead,If_Id_inst_code[6:0],Id_O_Ex_opcode,If_c_Id_Read_Data_2_Sel,Id_Ex_Read_Data_2_Sel);
       
	   // Stalling unit(O/P --> To stop PC,IF/ID register clocking & make control signal 0 
       stalling_unit s_u(Ex_O_Mem_Reg_Write,Ex_O_Mem_MemRead,Ex_O_Mem_Rd,Id_O_Ex_MemRead,Id_O_Ex_Reg_Write,Id_O_Ex_Rd,Id_Out_Ex_Rs2,If_Id_Rs2,If_Id_Rs1,
	   If_Id_inst_code[6:0],Id_O_Ex_opcode,Pc_Write,If_Id_Write,control_sel);
       
	   // ************************************************************ EX stage ****************************************************************************
	   
	   // Alu unit
       
       // Mux unit for selecting Read_data_2 or sign extension address 
       mux_read_data_2_Sel Rs_2(Id_Ex_Read_Data_2_Sel,Id_0_Ex_Sign_Ex,Mux_selected_read_Data,Alu_Input_2);
       ALU alu(Alu_Input_1,Alu_Input_2,Id_O_Ex_acl,aluresult,Zero);
	   
       // EX/MEM pipeine register
       EX_MEM_Reg Ex_Mem(clk,reset,Id_Out_Ex_Rs1,Id_Out_Ex_Rs2,Id_O_Ex_Rd,aluresult,Id_O_Ex_Reg_Write,Id_O_Ex_Output_Select,Ex_O_Mem_Rs1,Ex_O_Mem_Rs2,Ex_O_Mem_Rd,
       Ex_O_Aluresult,Ex_O_Mem_Reg_Write,Ex_O_Mem_Output_Select,Id_O_Ex_MemWrite,Id_O_Ex_MemRead,Ex_O_Mem_MemWrite,Ex_O_Mem_MemRead,Mux_selected_read_Data,Mem_WriteData);
	   
	   // ************************************************************ MEM stage ****************************************************************************
	   
       // MEM/WB pipeline register
       MEM_WB_Reg Mem_Wb(clk,reset,Ex_O_Mem_Rs1,Ex_O_Mem_Rs2,Ex_O_Mem_Rd,Ex_O_Aluresult,Ex_O_Mem_Reg_Write,Ex_O_Mem_Output_Select,Mem_O_Wb_Rs1,Mem_O_Wb_Rs2,Mem_O_Wb_Rd,
       Mem_O_Wb_Aluresult,Mem_O_Wb_Reg_Write,Mem_O_Wb_Output_Select,Ex_O_Mem_MemRead,Mem_0_Wb_MemRead,Mem_ReadData,Mem_O_Wb_Mem_ReadData);
	   
       // Data Memory
       Data_mem D_M(reset,Ex_O_Mem_MemRead,Ex_O_Mem_MemWrite,Ex_O_Aluresult,Mux_Mem_WriteData,Mem_ReadData);
       // Forwarding unit
       Forward_unit F1(Mem_0_Wb_MemRead,Ex_O_Mem_Reg_Write,Ex_O_Mem_Rd,Mem_O_Wb_Reg_Write,Mem_O_Wb_Rd,Id_Out_Ex_Rs1,Id_Out_Ex_Rs2,Id_O_Ex_MemWrite,
Id_O_Ex_opcode,Forward_Rs1,Forward_Rs2,
       Forward_Rs1_to_Id,Forward_Rs2_to_Id,Ex_O_Mem_MemWrite,Ex_O_Mem_Rs2,Fwd_Mem_to_Mem);
       // Input 1 selection of alu
       Mux alu_input1(ID_EX_Read_Data_1,Ex_O_Aluresult,processor_output,Forward_Rs1,Alu_Input_1);
       // Input 2 selection of alu
       Mux alu_input2(ID_EX_Read_Data_2,Ex_O_Aluresult,processor_output,Forward_Rs2,Mux_selected_read_Data);
       // Mux selection for write data in Data memory - considering forwarding case
       Mux_mem_writedata Mux_Mem(Mem_O_Wb_Mem_ReadData,Mem_WriteData,Fwd_Mem_to_Mem,Mux_Mem_WriteData);
	   
	   // ************************************************************ WB stage ****************************************************************************
	   
        // Output selection unit
       output_select output_s(Mem_O_Wb_Output_Select,Mem_O_Wb_Aluresult,Mem_O_Wb_Mem_ReadData,processor_output);
	   assign p_o = processor_output;
endmodule
