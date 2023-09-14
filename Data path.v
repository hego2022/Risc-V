`timescale 100ps/10ps
module Data_path #(
    parameter[10:0] N=32
) (
input clk, rst ,    
input  [1:0]WBsel,
input  PCsel,RegWE,B_en,Bsel,Asel,MemWE,
input [2:0]immsel,ALUsel,
output B_eq,B_neq,
output wire [N-1 :0]inst 
);

//Wire PCsel,RegWE,B_en,Bsel,Asel,MemWE,B_eq,B_neq,
reg [N-1 :0] pc_id,pc_ex,pc_data, data_wb,data_wbd,data_rd1,data_rd2,data_rdd2,Alu_o,Alu_od ;
wire [N-1 :0]pc_i, pc_o ,Alu,data_r1,data_r2,imm,Mem,As,Bs; 
PC  i0(clk,rst,pc_i,pc_o);  // program counter
 //program counter mux 
assign #0.1  pc_i=PCsel? Alu:(pc_o+4);
mem imem(0,pc_o[9:0],clk,rst,1'h0,inst);//instruction memory
R_file i1(data_wb,inst[19:15],inst[24:20],inst[11:7],clk,rst,RegWE,data_r1,data_r2);
immgen i2(inst,immsel,imm);
ALU  i3(As,Bs,ALUsel,Alu); //instiating Alu
assign #0.1  As= Asel?pc_o:data_r1;
assign #0.1 Bs= Bsel?imm :data_r2; //muxing data A
//assign  Bs= Bsel?imm :data_rd2;    //muxing data B
br_comb  i4(data_r1,data_r2,inst,B_en,B_eq,B_neq); //instatiating branch comp 
dmem  dmem (data_r2,Alu,clk,rst,MemWE,Mem);
always @* 
begin
 
 case (WBsel)
   2'h0 : #0.1 data_wb=Mem;
   2'h1 : #0.1 data_wb=Alu;
   2'h2 : #0.1 data_wb=pc_o+4;
  default: #0.1 data_wb=0;
 endcase   
end
endmodule