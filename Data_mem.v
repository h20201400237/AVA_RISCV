`timescale 1ns / 1ps

module Data_mem(
  
    input rst,  //global signal
    
    input Mem_Read,     //control signals
    input Mem_Write,
    
    input [31:0] M_a,               // data signals
    input [31:0] Mem_WriteData,
    output reg [31:0] Mem_ReadData

    );
    
    
    reg [31:0] mem [31:0];
        
      
    always @(rst,Mem_Write,M_a,Mem_WriteData,Mem_Write,M_a,Mem_Read)
    begin
            
           if(Mem_Read ==1)begin
                 Mem_ReadData = {mem[M_a+3],mem[M_a+2],mem[M_a+1],mem[M_a]}; // Reading the data from memory
           end
              
           if( rst==0 ) begin
              
                        mem[3]= 32'hxx ;  mem[2]= 32'hxx ;  mem[1]= 32'hxx ;  mem[0]= 32'hxx ;
                        mem[7]= 32'hxx ;  mem[6]= 32'hxx ;  mem[5]= 32'hxx ;  mem[4]= 32'hxx ;
                        mem[11]= 32'hxx ; mem[10]= 32'hxx ; mem[9]= 32'hxx ;  mem[8]= 32'hxx ;
                        mem[15]= 32'hxx ; mem[14]= 32'hxx ; mem[13]= 32'hxx ; mem[12]= 32'hxx ;
                        mem[19]= 32'hxx ; mem[18]= 32'hxx ; mem[17]= 32'hxx ; mem[16]= 32'hxx ;
                        mem[23]= 32'hxx ; mem[22]= 32'hxx ; mem[21]= 32'hxx ; mem[20]= 32'h05 ;
                        mem[27]= 32'hxx ; mem[26]= 32'hxx ; mem[25]= 32'hxx ; mem[24]= 32'hxx ;
                        mem[31]= 32'hxx ; mem[30]= 32'hxx ; mem[29]= 32'hxx ; mem[28]= 32'hxx ;
                        
                      
           end
           
           else begin
                if(Mem_Write == 1)
                    {mem[M_a+3],mem[M_a+2],mem[M_a+1],mem[M_a]} = Mem_WriteData;
           end
    
    end
    
endmodule
