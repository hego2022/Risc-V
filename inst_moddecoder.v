module inst_moddecoder #(
    parameter N=5
) (
    input [N-1:0]inst,
    output reg[2:0] state
);
 parameter [2:0] R=3'h0,
                I=3'h1,   
                S=3'h2,
                B=3'h3,
                J=3'h4,
                NOP=3'h5;
always @* begin      
case (inst)
   5'b01100 :state=R;
   5'b00100 :state=I;
   5'b11001 :state=I;
   5'b00000 :state=I;
   5'b01000 :state=S;
   5'b11000 :state=B;
   5'b11011 :state=J;
    default: state=NOP;
endcase
end
endmodule