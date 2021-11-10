`timescale 1ns / 1ps

module mux_read_data_2_Sel(
    input [1:0] If_Id_Read_Data_2_Sel,
input [31:0] Id_0_Ex_Sign_Ex,
input [31:0] ID_EX_Read_Data_2,
output reg  [31:0] Mux_selected_read_Data
    );
        always @(*)
    begin
    if(If_Id_Read_Data_2_Sel ==2'b01)
    Mux_selected_read_Data =ID_EX_Read_Data_2; // for r-type , branch instructions
    else
    Mux_selected_read_Data = Id_0_Ex_Sign_Ex;  // for i-type , load and store instructions - immediate data or address
    end
endmodule
