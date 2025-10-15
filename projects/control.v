`timescale 1ns / 1ps


/*
module control(
    input        clk,
    input        start_n,
    input  [8:0] divisor_mag,
    input        diff_neg,
    output reg   enable,
    output reg   bit_in,
    output reg   done,
    output reg   DVZ
);
    localparam S_INIT = 2'b00, S_COUNT = 2'b01, S_ERROR = 2'b10;
    reg [1:0] state, next_state;
    reg [3:0] cnt, next_cnt;

    always @(posedge clk) begin
        state <= next_state;
        cnt   <= next_cnt;
    end

    always @* begin
        enable   = 1'b0;
        bit_in   = 1'b0;
        done     = 1'b0;
        DVZ      = 1'b0;
        next_state = state;
        next_cnt   = cnt;
        case (state)
            S_INIT: begin
                done = 1'b1;
                next_cnt = 4'd0;
                if (!start_n) begin
                    if (divisor_mag == 9'd0) next_state = S_ERROR;
                    else next_state = S_COUNT;
                end
                
                
                
                else begin
                    next_state = S_INIT;
                end
                
                
            end
            S_COUNT: begin
                enable = 1'b1;
                bit_in = diff_neg ? 1'b0 : 1'b1;
                if (cnt == 4'd7) begin
                    next_state = S_INIT;
                    next_cnt   = 4'd0;
                end else begin
                    next_cnt = cnt + 1'b1;
                end
            end
            S_ERROR: begin
                DVZ = 1'b1;
                if (!start_n && divisor_mag != 9'd0) begin
                    next_state = S_COUNT;
                    next_cnt   = 4'd0;
                end
            end
            default: begin
                next_state = S_INIT;    
                next_cnt   = 4'd0;
             end
        endcase
    end
endmodule

*/

module control(
    input        clk,
    input        start_n,
    input  [8:0] divisor_mag,
    input        diff_neg,
    output reg   enable,
    output reg   bit_in,
    output reg   done,
    output reg   DVZ
);
    localparam S_INIT = 2'b00, S_COUNT = 2'b01, S_ERROR = 2'b10;
    reg [1:0] state = S_INIT;
    reg [2:0] count = 3'b000;
    
    always @(posedge clk) begin
        /*
        enable <= 1'b0;
        bit_in <= 1'b0;
        done <= 1'b0;
        DVZ <= 1'b0;
        */
        
        case(state)
           S_INIT:  begin
                    enable <= 1'b0;
                    done <= 1'b1;
                    DVZ <= 1'b0;
                    if (!start_n) begin
                        if (divisor_mag == 9'd0) begin
                            state <= S_ERROR;
                            end
                        else begin
                            state <= S_COUNT;
                            count <= 3'b000;
                            end
                        end
                    else begin
                        state <= S_INIT;
                        end               
                    end
            
            S_ERROR: begin
                     enable <= 1'b0;
                     done <= 1'b0;
                     DVZ <= 1'b1;
                     if (!start_n && divisor_mag != 9'd0) begin
                         state <= S_COUNT;
                         count <= 3'b000;
                         end
                     end
            S_COUNT: begin
                     enable <= 1'b1;
                     done <= 1'b0;
                     DVZ <= 1'b0;
                     
                     if (diff_neg) begin
                        bit_in <= 1'b0;
                        end
                     else begin
                        bit_in <= 1'b1;
                        end   
                     
                     if (count == 3'b111) begin
                        count <= 3'b000;
                        state <= S_INIT;
                        end
                     else begin
                        count <= count + 1'b1;
                        state <= S_COUNT;
                        end
                     end 
            default: state <= S_INIT;                    
        endcase                     
    end
endmodule    
