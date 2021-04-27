`timescale 1ns/1ps

`include "head.c"

`define half_period 5

module test;
	reg clk, ena;
	reg  [`DATABUS] d_inX;		
	reg [`DATABUS] d_inY;
	reg [1:0] op;
	reg [`DATABUS] inX[3:0];		//4组测试数据
	reg [`DATABUS] inY[3:0];
	wire [`DATABUS] d_out;
	
	parameter STEP = 100.0000;     //10M
		
	initial begin
		$dumpfile("ALU.vcd");
		$dumpvars(0, test);
	end

	
	
	always #(STEP/2) begin
		clk <= ~clk;
	end

	initial begin
		/**
		*测试集初始化
		*/
		#0 begin
		  inX[0] <= `DATAW'd8888; inY[0] <= `DATAW'd5555; 
		  inX[1] <= `DATAW'd2321; inY[1] <= `DATAW'd1234;
		  inX[2] <= `DATAW'd6546; inY[2] <= `DATAW'd234;
		  inX[3] <= `DATAW'd1123; inY[3] <= `DATAW'd634;
		end
	end
	
	initial begin
		#0 begin
			d_inX <= 0; d_inY <= 0;
		    clk <= 0; ena <= 0; op <= 2'b00;
			ena <= 1;
		end
		
		for(integer  i = 0;i < 4;i ++)begin
			#STEP d_inX <= inX[i]; d_inY <= inY[i];
		  	for(integer j = 0;j < 4;j ++)begin
				  #STEP op <= j;
		  	end
		end

		#STEP begin
			$finish;
		end
	end

	ALU ALU(
		.clk(clk),
		.ena(ena),
		.d_inX(d_inX),
		.d_inY(d_inY),
		.op(op),
		.d_out(d_out)
	);
endmodule
