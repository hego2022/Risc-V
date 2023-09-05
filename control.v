module cont #(
    parameter N=32
) (
    input [N-1:0]inst,
    input clk,rst,B_eq,B_neq,
    output reg PCsel,RegWE,B_en,Bsel,Asel,MemWE,
    output reg[1:0]WBsel,
    output reg [2:0]immsel,ALUsel
);
parameter [2:0] R=3'h0,
                I=3'h1,   
                S=3'h2,
                B=3'h3,
                J=3'h4;
reg[N-1:0]inst_exc,inst_data,inst_wb;
wire [2:0]s0,s1,s2;
//know which mode you are operating in
inst_moddecoder d0(inst_exc[6:2],s0);
inst_moddecoder d1(inst_data[6:2],s1);
inst_moddecoder d2(inst_wb[6:2],s2);
/////insttucyion pipelining
always @(posedge clk ) begin
    inst_exc<=inst;
    inst_data<=inst_exc;
    inst_wb<=inst_data;
end
///
always @(posedge clk ,posedge rst) begin: Execution
    if (rst==1) begin
      B_en=0;
      Bsel=0;
      Asel=0;
      immsel=0;
      ALUsel=0;  
    end
  //Excution control signals
  else begin
    if (s0==R) begin
      B_en=0; //data path signals
      Bsel=0;
      Asel=0;
      immsel=0;
      //arthmitic op
      if (inst[14:12]==3'h0 &inst[30]==0) //add
      begin
        ALUsel=3'h0;  
      end
      if (inst[14:12]==3'h0 &inst[30]==1) //sub
      begin
        ALUsel=3'h1;  
      end
      if (inst[14:12]==3'h7) //and
      begin
        ALUsel=3'h2;  
      end
       if (inst[14:12]==3'h6) //or
      begin
        ALUsel=3'h3;  
      end    
    end
  if (s0==I) begin
      B_en=0; //data path signals
      Bsel=1;
      Asel=0;
      immsel=I;
      //arthmitic op
      if (inst[14:12]==3'h0 | inst[14:12]==3'h2) //addi - LW- Jlar
      begin
        ALUsel=3'h0;  
      end
      if (inst[14:12]==3'h7) //andi
      begin
        ALUsel=3'h2;  
      end
       if (inst[14:12]==3'h6) //ori
      begin
        ALUsel=3'h3;  
      end    
    end  
if (s0==S) 
  begin //SW
      B_en=0; //data path signals
      Bsel=1;
      Asel=0;
      immsel=S;
      ALUsel=3'h0;  
  end
if (s0==B) 
  begin //Beq -Bneq
      B_en=1; //data path signals
      Bsel=1;
      Asel=1;
      immsel=B;
      ALUsel=3'h0;  
  end
 if (s0==J) 
  begin //Jal
      B_en=0; //data path signals
      Bsel=1;
      Asel=1;
      immsel=J;
      ALUsel=3'h0;  
  end 
 end
end  :Execution 
//data control block
always @(posedge clk,posedge rst ) begin:data
    if (rst==1) begin
        MemWE=0;
    end
    else begin
    if (s1==S) begin
      MemWE=1;  
    end
    else begin
        MemWE=0;
    end
    end
end
always @(posedge clk,posedge rst ) begin:WB
if (rst==1) begin
    PCsel=0;
    WBsel=0;
    RegWE=0;
end
else begin
    if (s2==R |s2==I) begin
    PCsel=0;
    RegWE=1;
    if (inst_wb[6:2]==5'b11001) begin
     PCsel=1;
     WBsel=2;   
    end 
    if (inst_wb[6:2]==5'b00000) begin
     WBsel=0;   
    end 
    end
    if (s2==S) begin
    PCsel=0;
    WBsel=0;
    RegWE=0;       
    end
    if (s2==B) begin
    WBsel=0;
    RegWE=0;
    if (inst_wb[14:12]==3'b000 &B_eq==1) begin //branching conditions
        PCsel=1;
    end  
    if (inst_wb[14:12]==3'b001 & B_neq==1) begin
        PCsel=1;
    end  
    else begin
       PCsel=0;  
    end
    end
    if (s2==J) begin
       RegWE=1;
       PCsel=1;
       WBsel=2;   
    end
end
end:WB
endmodule