
module tb_multicycle;


reg clk;
reg rst_n;


multi_cycle P (.clk(clk), .rst_n(rst_n));

always begin
    #5 clk = ~clk;
end


initial begin
   
    clk = 0;
    rst_n = 0;
    #6 rst_n = 1;
    #100 $finish;
end
