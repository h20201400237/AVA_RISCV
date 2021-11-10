`timescale 1ns / 1ps
module sign_extented(
    inout [6:0]opcode_sel,
    input [31:0] i ,
    output reg [31:0] sign_Ex //signextended output
    );
    
     reg [1:0]check;
    
    
    always@(opcode_sel,i)
    begin
    //load instruction address calculation and immediate data for i -type instructions
    if ((opcode_sel != 7'b0100011) & (opcode_sel != 7'b1100111) & (opcode_sel != 7'b1101111))
    begin
    sign_Ex = {{20{i[31]}},i[31:20]}; 
    end
    // store instruction address calculation
    else if (opcode_sel == 7'b0100011)
    begin
    sign_Ex = {{20{i[31]}},i[31:25],i[11:7]}; 
    end
    // branch offset
    else if (opcode_sel == 7'b1100111)
    begin
    sign_Ex = {{20{i[31]}},i[31],i[7],i[30:25],i[11:8]};
    end
    // JUMP offset
    else if (opcode_sel == 7'b1101111)
    begin
    sign_Ex = {{12{i[31]}},i[31],i[19:12],i[20],i[30:21]};
    end
    end  
    
endmodule
