`timescale 100ps/10ps
module tb_;
reg clk;
reg rst;

Top dut
(.rst (rst),
 .clk (clk)
);

localparam CLK_PERIOD = 1;
initial
begin
    clk=0;
    forever begin
      #(CLK_PERIOD*5) clk=~clk;  
    end
end
initial begin
    rst<=1'b1;
    #(CLK_PERIOD*5) rst<=0;
    $readmemh("hex.hex", dut.s1.imem.d_mem) ;
    #(CLK_PERIOD*60*5) ;
    $stop ;  
end

endmodule
