module R_file #(
    parameter N=32,
    M=5
) (
    input [N-1:0]data_w,
    input[M-1:0]adrs_r1,adrs_r2,adrs_w,
    input clk,rst,
    output [N-1:0]data_r1,data_r2 
);
reg [N-1:0]regfile[(2**M)-1:0];
integer i;
always @(posedge clk ) begin
 if (rst==1) begin
    for ( i=0 ;i<N ;i=i+1 ) begin
        regfile[i]=0;
    end
 end   
 else
 begin
    regfile[adrs_w]=data_w;
 end
end
assign data_r1=regfile[adrs_r1];
assign data_r2=regfile[adrs_r2];
    
endmodule