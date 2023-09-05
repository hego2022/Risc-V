module ALU #(
   parameter N =32 
) (
    input [N-1:0] A,B,
    input [2:0]op,
    output reg [N-1:0]R 

);
reg cin;
wire[N-1:0]r;
reg[N-1:0]b;
Adder s0(cin,A,B,r,);
always @* begin
    case (op)
        3'h0: begin //Addition
            cin=0;
            R=r;
              end
        3'h1: begin //subtraction
            cin=1;
            b=~b;
            R=r;
              end
        3'h2:R=A&B; //Anding
        3'h3:R=A|B; //Oring
        3'h4:R=A^B; //Xoring
        default: R=R; //NOP
    endcase
end
 assign B=b;   
endmodule