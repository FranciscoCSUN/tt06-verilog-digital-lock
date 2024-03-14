`timescale 1ns / 1ps

module debouncer(
    input button,
    input clk,
    output result
);
    parameter N = 8;
    reg ff1 = 0;
    reg ff2 = 0;
    reg ff3 = 0;
    reg [N:0] counter = 0;
    wire ena;
    wire sclr;
    
    assign sclr = ff2 ^ ff1;
    assign ena = counter[N];
    
    always@(posedge clk) begin
        ff2 <= ff1;
        ff1 <= button;
    end
    
    always@(posedge clk)
        if (sclr)
            counter <= 0;
        else if (~ena)
            counter <= counter + 1;
    
    always@(posedge clk)
        if (ena)
            ff3 <= ff2;
    
    assign result = ff3;
    
endmodule
