module immgen #(
    parameter N=32
) (
    input [N-1:0] inst,
    input[2:0]immsel,
    output reg [N-1:0]imm
);
parameter [2:0] R=3'h0,
                I=3'h1,   
                S=3'h2,
                B=3'h3,
                J=3'h4;
always @* 
begin
   case (immsel)
   I :begin
     imm={{20{inst[31]}},inst[31:20]} ; 
      end 
   S :begin
     imm={{20{inst[31]}},inst[31:25],inst[11:7]} ;
      end 
   B :begin
     imm={{19{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8],1'h0} ;
      end 
   J : begin
      imm={{12{inst[31]}},inst[7],inst[30:25],inst[11:8],1'h0} ;     
      end   
   default:imm=0;
   endcase   
end 
endmodule