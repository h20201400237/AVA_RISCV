`timescale 1ns / 1ps

module output_select(
    input [1:0] control_signal,
input [31:0] alu_output,
input [31:0] Mem_ReadData,
output reg [31:0] processor_output
    );
        reg [1:0] check;
    //Mux to select the load immediate data or alu result based on opcode
    always @(control_signal,alu_output,Mem_ReadData)
    begin
    if(control_signal==2'b01)
    begin
    check = 2'b01;
    //select alu ouput
    processor_output = alu_output;
    end
    else
    begin
    //select load immediate output
    processor_output=Mem_ReadData;
    check = 2'b00;
    end
    end
endmodule
