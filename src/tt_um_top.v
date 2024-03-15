`timescale 1ns / 1ps

module tt_um_top(
    input  [7:0] ui_in,
    output [7:0] uo_out,
    input  [7:0] uio_in,
    output [7:0] uio_out,
    output [7:0] uio_oe,
    input  ena,
    input  clk,
    input  rst_n
    );
    
    wire [3:0] led;
    wire [3:0] dig;

    wire [3:0] debounced;
    wire [3:0] signal;
    
    parameter VPWR = 1'b1;
    parameter VGND = 1'b0;

    debouncer db0(.button(ui_in[0]), .clk(clk), .result(debounced[0]) );
    debouncer db1(.button(ui_in[1]), .clk(clk), .result(debounced[1]) );
    debouncer db2(.button(ui_in[2]), .clk(clk), .result(debounced[2]) );
    debouncer db3(.button(ui_in[3]), .clk(clk), .result(debounced[3]) );
    
    edgeDetector ed0(.in(debounced[0]), .clk(clk), .out(signal[0]) );
    edgeDetector ed1(.in(debounced[1]), .clk(clk), .out(signal[1]) );
    edgeDetector ed2(.in(debounced[2]), .clk(clk), .out(signal[2]) );
    edgeDetector ed3(.in(debounced[3]), .clk(clk), .out(signal[3]) );

    digital_lock dl0(.button(signal), .clk(clk), .rstn(rst_n), .led(led));

    seven_segment_ctrl ssc0(.clk(clk), .led(led), .seven_seg(uo_out[6:0]), .dig(dig));

endmodule
