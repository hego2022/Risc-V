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
    if (inst[31]==0) begin
      imm={20'h0,inst[31:20]} ;   
    end
    if (inst[31]==1) begin
     imm={20'hFFFFF,inst[31:20]} ; 
    end
      end 
   S :begin
    if (inst[31]==0)begin
      imm={20'h0,inst[31:25],inst[11:7]} ;
                    end
   if (inst[31]==1) begin
     imm={20'hFFFFF,inst[31:25],inst[11:7]} ;
                    end
      end 
   B :begin
    if (inst[31]==0)begin
      imm={19'h0,inst[31],inst[7],inst[30:25],inst[11:8],1'h0} ;
                    end
   if (inst[31]==1) begin
     imm={19'h7FFFF,inst[31],inst[7],inst[30:25],inst[11:8],1'h0} ;
                    end
      end 
   J : begin
    if (inst[31]==0)begin
      imm={11'h0,inst[31],inst[7],inst[30:25],inst[11:8],1'h0} ;
                    end
   if (inst[31]==1) begin
     imm={11'h7FF,inst[31],inst[19:12],inst[20],inst[30:21],1'h0} ;
                    end
      end   
   default:imm=0;
   endcase   
end 
endmodule