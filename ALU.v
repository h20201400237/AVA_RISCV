`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2020 07:43:50 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    
        input [31:0] a,//operand 1
        input [31:0] b,//operand 2
        input [3:0] acl,//alu control unit              ** // need to change
        
        output reg[31:0] aluresult,//alu result
        output reg Zero//zero flag
    
    );
    
    always@(a,b,acl)
    begin
    
    
    if(acl == 4'b0000 )
       begin
       aluresult = a+b; // add,addi instrcution
       end
    else if(acl== 4'b0001)
       begin
       aluresult = a-b; // sub,subi instrcution
       end 
    else if(acl== 4'b0010)
       begin
       aluresult = a<<b;  // sll instrcution
       end
    else if(acl== 4'b0011)
       begin
       aluresult = a<b;  // slt,slti instrcution
       end
    else if(acl== 4'b0100)
       begin
       aluresult= a^b;  // xor,xori instrcution
       end
    else if(acl== 4'b0101)
       begin
       aluresult= a>>b;  // srl instrcution
       end
    else if(acl== 4'b0110)
       begin
       aluresult= a | b;  // or,ori instrcution
       end
    else if(acl==4'b0111)
       begin
       aluresult= a&b;  // and,andi instrcution
       end
 
              
        if(aluresult==0)
            Zero=1;//Setting zero flag is alu result is zero
        else
            Zero=0;
   
    end


endmodule
