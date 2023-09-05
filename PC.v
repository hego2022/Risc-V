module PC #(
    parameter N=8
) (
    input clk,rst,
    input [N-1:0]pc_in,
    output reg[N-1:0]pc_out
);
    always @(posedge clk ,posedge rst) begin
        if (rst==1) 
        pc_out<=0;
        else
        pc_out<=pc_in;
    end
endmodule