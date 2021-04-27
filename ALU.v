/**
*ALU模块
*功能：32位数据 '+' '-' '&' '^'运算
*输入：32位inX，32位inY，2位 op
*输出：32位out
*/

`include "head.c"
module ALU(
    input wire clk,
    input wire ena,
    input wire[`DATABUS] d_inX,
    input wire[`DATABUS] d_inY,
    input wire[1:0] op,
    output wire[`DATABUS] d_out
);
    reg[`DATABUS] out;
    always @(posedge clk) begin
        if(ena) begin
                case(op)
                    2'b00: out <= d_inX + d_inY;
                    2'b01: out <= d_inX - d_inY;
                    2'b10: out <= d_inX & d_inY;
                    2'b11: out <= d_inX ^ d_inY;
                    default: out <= 0;
                endcase
            end
    end
    assign d_out = out;

endmodule
