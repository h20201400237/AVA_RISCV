`timescale 1ns / 1ps

module PC_select(

    input clk,
    input rst,
    
    input Pc_Write,                // To stop PC clocking
    input beq_pc_sel,
    input jump_pc_sel,
    
    input [31:0] jump_address,
    input [31:0] branch_address,
    input [31:0] PC_Inc,
    
    output reg [31:0] PC_Sel

    );
    
    always @(posedge clk)
    begin
        if(rst == 0)begin
            PC_Sel =0;
        end
        
        else begin
            
            // Incrementing the PC
            if(Pc_Write == 1)begin
                PC_Sel = PC_Inc;
            end
            
            // To select the branch address
            else if(beq_pc_sel ==1)begin
                PC_Sel = branch_address;
            end
            
            // To select the jump address
            else if(jump_pc_sel ==1)begin
                PC_Sel = jump_address;
            end
            
            // To stall the PC 
            else begin
                PC_Sel = PC_Sel;
            end
        end
    
    end

endmodule
