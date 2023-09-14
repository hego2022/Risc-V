`timescale 100ps/10ps
module ALU #(
   parameter[10:0] N =32 
) (
    input [N-1:0] A,B,
    input [2:0]op,
    output reg [N-1:0]R 
);
reg cin;
wire[N-1:0]r;
reg[N-1:0]b;
Adder s0(cin,A,B,,r);
always @* begin
    case (op)
        3'h0: begin //Addition
           #0.5 R=A+B;
              end
        3'h1: begin //subtraction
           #0.5 R=A-B;
              end
        3'h2: #0.5 R=A&B; //Anding
        3'h3: #0.5 R=A|B; //Oring
        3'h4: #0.5 R=A^B; //Xoring
        default: #0.5  R=R; //NOP
    endcase
end
   
endmodule