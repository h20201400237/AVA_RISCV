`timescale 1ns / 1ps

module instruction_mem(
        
        input rst,
        input [31:0] PC,
        output [31:0] instr_code
    );
    
    reg [7:0] mem [99:0];
    
    assign instr_code = {mem[PC+3],mem[PC+2],mem[PC+1],mem[PC]};
	/*
	    add t1,s3,s4;
		beq t5,s5,L1;
		sub t2,t1,t3;
	L1:	add t2,t1,t3;
	*/
    
    always@(rst)begin
    
    if(rst)begin
                mem[3] = 32'h01;  mem[2] = 32'h43;  mem[1] = 32'h0f;  mem[0] = 32'h13;  // 01498333
                mem[7] = 32'h00 ; mem[6]= 32'h03 ;  mem[5]= 32'h0e ;  mem[4]= 32'h13 ;  // 015e0867
                mem[11]= 32'h00 ; mem[10]= 32'h0f ; mem[9]= 32'h2e ;  mem[8]= 32'h83 ;  // 41c303b3
                mem[15]= 32'h01 ; mem[14]= 32'hde ; mem[13]= 32'h0e ; mem[12]= 32'h33 ; // 01c303b3
               mem[19]= 32'hff ; mem[18]= 32'hfe ; mem[17]= 32'h8e ; mem[16]= 32'h93 ;
                mem[23]= 32'hfe ; mem[22]= 32'h7e ; mem[21]= 32'h9e ; mem[20]= 32'he7 ;
                mem[27]= 32'hff ; mem[26]= 32'hce ; mem[25]= 32'h2f ; mem[24]= 32'h23 ;
              /*  mem[31]= 32'hxx ; mem[30]= 32'hxx ; mem[29]= 32'hxx ; mem[28]= 32'hxx ;
                mem[35]= 32'hxx ; mem[34]= 32'hxx ; mem[33]= 32'hxx ; mem[32]= 32'hxx ;
                mem[39]= 32'hxx ; mem[38]= 32'hxx ; mem[37]= 32'hxx ; mem[36]= 32'hxx ;
                mem[43]= 32'hxx ; mem[42]= 32'hxx ; mem[41]= 32'hxx ; mem[40]= 32'hxx ;   */
        
        
    end    
    end
    
endmodule
