`timescale 100ps/10ps
module PC #(
    parameter[10:0] N=32
) (
    input clk,rst,
    input [N-1:0]pc_in,
    output reg[N-1:0]pc_out
);
    always @(posedge clk ,posedge rst) begin
        if (rst==1) 
        pc_out<=0;
        else
        #0.1 pc_out<=pc_in;
    end
endmodule