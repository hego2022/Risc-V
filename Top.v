
module Top #(
    parameter N=32
)(
    input wire clk, rst 
) ;
wire  [1:0]WBsel;
wire  PCsel,RegWE,B_en,Bsel,Asel,MemWE,B_eq,B_neq;
wire [2:0]immsel,ALUsel;
wire  [N-1 :0]inst ;


cont s0(inst,clk,rst,B_eq,B_neq,PCsel,RegWE,B_en,Bsel,Asel,MemWE,WBsel,immsel,ALUsel);
Data_path s1(clk, rst ,WBsel,PCsel,RegWE,B_en,Bsel,Asel,MemWE,immsel,ALUsel,B_eq,B_neq,inst);
endmodule