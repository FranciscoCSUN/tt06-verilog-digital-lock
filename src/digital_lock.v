`timescale 1ns / 1ps

module digital_lock(
    input  [3:0] button,
    input  clk,
    input  rstn,
    output [3:0] led
);

	// states identified
	parameter [3:0] KEY0 = 4'b0100, 
	                KEY1 = 4'b1000, 
	                KEY2 = 4'b0010, 
	                KEY3 = 4'b0001;
    parameter [4:0] IDLE     = 5'b00000, 
	                CORRECT0 = 5'b00001, 
	                CORRECT1 = 5'b00010, 
	                CORRECT2 = 5'b00100, 
	                OPEN     = 5'b01111, 
	                WRONG0   = 5'b10001, 
	                WRONG1   = 5'b10010, 
	                WRONG2   = 5'b10100, 
	                CLOSED   = 5'b11000;
	reg [4:0] current_state = IDLE;
	reg [4:0] next_state = IDLE;
	
    assign led = current_state[3:0];

	// assign state actions
	always@(current_state, button)
        case(current_state)
            IDLE: 
			begin
			     if (button == 4'b0100)
			         next_state = CORRECT0;
			     else if (button > 0)
			         next_state = WRONG0;
			     else
			         next_state = IDLE;
			end
			CORRECT0: 
			begin
			     if (button == KEY1)
			         next_state = CORRECT1;
			     else if (button > 0)
			         next_state = WRONG1;
			     else
			         next_state = CORRECT0;
			end
			CORRECT1: 
			begin
			     if (button == KEY2)
			         next_state = CORRECT2;
			     else if (button > 0)
			         next_state = WRONG2;
			     else
			         next_state = CORRECT1;
			end
			CORRECT2: 
			begin
			     if (button == KEY3)
			         next_state = OPEN;
			     else if (button > 0)
			         next_state = CLOSED;
			     else
			         next_state = CORRECT2;
			end
			OPEN:
			begin
			     next_state = OPEN;
			end
			WRONG0: 
			begin
			     if (button > 0)
			         next_state = WRONG1;
			     else
			         next_state = WRONG0;
			end
			WRONG1: 
			begin
			     if (button > 0)
			         next_state = WRONG2;
			     else
			         next_state = WRONG1;
			end
			WRONG2: 
			begin
			     if (button > 0)
			         next_state = CLOSED;
			     else
			         next_state = WRONG2;
			end
			CLOSED:
			begin
			     next_state = CLOSED;
			end
			default: // default IDLE state
			begin
                 next_state = IDLE;
			end
		endcase
	
	// sequential logic for assigning STATES
	always@(posedge clk or negedge rstn) 
	begin
		// transition to next state at next rising edge
		if(!rstn)
		      current_state = IDLE;
		else
		      current_state = next_state;
	end

endmodule