`timescale 100ps/10ps
module dmem 
   #(
    parameter N=32,
    M=10
) (
    input [N-1:0]data_w,
    input[M-1:0]adrs,
    input clk,rst,WE,
    output [N-1:0]data_r 
);
integer i;
reg[N-1:0]d_mem[(2**M)-1:0];
always @(posedge clk, posedge rst  ) begin
    if (rst==1) begin
       for ( i=0 ;i<1024 ;i=i+1 )
             begin
             d_mem[i]=0;
             end   
    end
    else
    if (WE==1) begin
       d_mem[adrs/4]=data_w; 
    end   
end
    assign #1 data_r=d_mem[adrs/4];
endmodule