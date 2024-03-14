`timescale 1ns / 1ps

module seven_segment_ctrl(
    input  clk,
    input  [3:0] led,
    output [6:0] seven_seg,
    output [3:0] dig
);
parameter [3:0] CLOSED  = 4'b1000,
                OPEN    = 4'b1111;
//          aa 
//        f    b
//        f    b
//          gg
//        e    c
//        e    c
//          dd
// seven segment leds:           abcdefg
parameter [6:0] IDLE_SSD    = 7'b0000000,
                OPEN_SSD_O  = 7'b1111110,
                OPEN_SSD_P  = 7'b1100111,
                OPEN_SSD_E  = 7'b1001111,
                OPEN_SSD_n  = 7'b0010101,
                CLOSED_SSD_E= 7'b1001111,
                CLOSED_SSD_r= 7'b0000101;
reg [6:0] seven_seg;             
reg [1:0] sel = 0;

assign dig[0] = ~(~sel[1] & ~sel[0]);
assign dig[1] = ~(~sel[1] &  sel[0]);
assign dig[2] = ~( sel[1] & ~sel[0]);
assign dig[3] = ~( sel[1] &  sel[0]);

always@(led, sel) begin
    case(led)
        CLOSED:
        begin
            case(sel)
                2'b00: seven_seg = 0;
                2'b01: seven_seg = CLOSED_SSD_E;
                2'b10: seven_seg = CLOSED_SSD_r;
                2'b11: seven_seg = CLOSED_SSD_r;
            endcase
        end
        OPEN:
        begin
            case(sel)
                2'b00: seven_seg = OPEN_SSD_O;
                2'b01: seven_seg = OPEN_SSD_P;
                2'b10: seven_seg = OPEN_SSD_E;
                2'b11: seven_seg = OPEN_SSD_n;
            endcase
        end
        default:
        begin
            seven_seg = IDLE_SSD;
        end
    endcase
end

always@(posedge clk) begin
    sel = sel + 1;
end
endmodule
