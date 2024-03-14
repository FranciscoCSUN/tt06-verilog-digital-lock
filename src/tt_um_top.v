`timescale 1ns / 1ps

module tt_um_top(
    input [3:0] button,
    input clk,
    input rstn,
    output [6:0] ssd,
    output [3:0] led,
    output [3:0] dig);

wire [3:0] debounced;
wire [3:0] signal;

debouncer db0(.button(button[0]), .clk(clk), .result(debounced[0]) );
debouncer db1(.button(button[1]), .clk(clk), .result(debounced[1]) );
debouncer db2(.button(button[2]), .clk(clk), .result(debounced[2]) );
debouncer db3(.button(button[3]), .clk(clk), .result(debounced[3]) );

edgeDetector ed0(.in(debounced[0]), .clk(clk), .out(signal[0]) );
edgeDetector ed1(.in(debounced[1]), .clk(clk), .out(signal[1]) );
edgeDetector ed2(.in(debounced[2]), .clk(clk), .out(signal[2]) );
edgeDetector ed3(.in(debounced[3]), .clk(clk), .out(signal[3]) );

digital_lock dl0(.button(signal), .clk(clk), .rstn(rstn), .led(led));

seven_segment_ctrl ssc0(.clk(clk), .led(led), .seven_seg(ssd), .dig(dig));

endmodule
