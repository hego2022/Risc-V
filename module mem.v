module mem 
   #(
    parameter N=32,
    M=10
) (
    input [N-1:0]data_w,
    input[M-1:0]adrs_r,adrs_w,
    input clk,rst,WE,
    output [N-1:0]data_r 
);
integer i;
reg[N-1:0]d_mem[(2**M)-1:0];
always @(posedge clk ) begin
    if (rst==1) begin
       for ( i=0 ;i<N ;i=i+1 )
             begin
             d_mem[i]=0;
             end   
    end
    else
    if (WE==1) begin
       d_mem[adrs_w]=data_w; 
    end   
end
    assign data_r=d_mem[adrs_r];
endmodule