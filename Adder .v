module Adder #(
    parameter N=31
) (
    input cin,
    input [N-1:0]A,B,
    input [1:0]op,
    output reg cout,
    output reg[N-1:0]R 
);
    always @* begin
        {cout,R}=A+B+cin;
    end
endmodule