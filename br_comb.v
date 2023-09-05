module br_comb #(
    parameter N=32
) (
    input[N-1:0]A,B,
    input B_en,
    output reg B_eq,B_neq
);
always @* begin
    if(A==B & (B_en==1))
    begin
    B_eq=1;
    B_neq=0;
    end
    else if (A!=B  & (B_en==1) ) begin
    B_eq=0;
    B_neq=1;   
    end
    else begin
    B_eq=0;
    B_neq=0;   
    end
end
endmodule