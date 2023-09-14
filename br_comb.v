module br_comb #(
    parameter [10:0]N=32
) (
    input[N-1:0]A,B,inst,
    input B_en,
    output reg B_eq,B_neq
);
wire [2:0]s0;
inst_moddecoder d0(inst[6:2],s0);
always @* begin
    if(A==B & (B_en==1) &(inst[14:12]==3'b000 ) )
    begin
    B_eq=1;
    B_neq=0;
    end
    else if (A!=B  & (B_en==1) &(inst[14:12]==3'b001)) begin
    B_eq=0;
    B_neq=1;   
    end
    else begin
    B_eq=0;
    B_neq=0;   
    end
end
endmodule
