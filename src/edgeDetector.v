`timescale 1ns / 1ps

module edgeDetector(
    input in,
    input clk,
    output out
);
    reg synch_ff1 = 0;
    reg synch_ff2 = 0;
    reg edgeff = 0;
    
    always@(posedge clk) begin
        edgeff <= synch_ff2;
        synch_ff2 <= synch_ff1;
        synch_ff1 <= in;
    end
    assign out = (~synch_ff2) & edgeff;
endmodule
