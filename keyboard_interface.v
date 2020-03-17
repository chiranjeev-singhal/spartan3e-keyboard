`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:42 05/03/2016 
// Design Name: 
// Module Name:    keyboard_interface 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module keyboard_interface(data_in,an,ca,clk);
  reg  nex;
  parameter IDLE=0,RUNNING=1;
  input clk,data_in;
  output reg [6:0]ca;
  output  reg [3:0]an;
  reg [7:0]a,out;
  reg [3:0]count;
  
  
  initial
    begin
	    count=0;
		
		 nex = 0;
	end
	

 always @(posedge clk)
      case(nex)
		 IDLE:if(data_in==1)
		       nex=IDLE;
				 else
				 nex=RUNNING;
				 
		 RUNNING: if (count<=7)
		           begin
							a=a>>1;
							a[7]=data_in;
							count=count+1;
						end
					else
					   begin
					     nex=IDLE;
				        out=a;
						  count=0;
						 end
			endcase
	
	
		 
		 always@(out)
			   begin
     				an=4'b0111;
				  case (out)
			     8'b00011100: ca=7'b0001000;//a
				  8'b00011101: ca=7'b0010010;//s
				  8'b00100011: ca=7'b1000000;//o
				  8'b00101011: ca=7'b0001110;//f
				  default : ca=7'b0111111;
				  
				endcase
         end

	endmodule
