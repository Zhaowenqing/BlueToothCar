
`timescale 1 ns / 1 ps

module mainController
(    
    input clk50M,
    input [3:0]DRT,
    input [15:0]SPD,
    output DIR_serial,
    output  DIR_enable,
    output  DIR_latch, 
    output [3:0]SPD_out,
    output clk1K
);  
    wire rst=1;
    wire clk1K_tem;
    divider d1(clk50M,clk1K_tem);
    assign clk1K=clk1K_tem;
    DRTController dc(clk1K_tem,rst,DRT[3:0],DIR_serial,DIR_enable,DIR_latch); 
    PWM P1(clk50M,rst,SPD[15:12],SPD_out[3]);
    PWM P2(clk50M,rst,SPD[11:8],SPD_out[2]);
    PWM P3(clk50M,rst,SPD[7:4],SPD_out[1]);
    PWM P4(clk50M,rst,SPD[3:0],SPD_out[0]);
endmodule

module DRTController(input clk,input rst,input [3:0]DRT,output reg DIR_serial,output reg DIR_enable,output reg DIR_latch);
    reg [3:0] state=0;
    always @ (negedge clk)
        begin
            if(!rst)
                begin
                    state=0;
                 end 
            case (state)
                0:
                    begin
                        DIR_serial <= DRT[0];
                        DIR_enable <= 1;
                        DIR_latch  <= 0;
						state      <= 1;
                    end
                1:
                    begin
                        DIR_serial <= ~DRT[0];
                        DIR_enable <= 1;
                        DIR_latch  <= 0;
						state      <= 2;
                    end
				2:
                    begin
                        DIR_serial <= DRT[1];
                        DIR_enable <= 1;
                        DIR_latch  <= 0;
						state      <= 3;
                    end
				3:
                    begin
                        DIR_serial <= ~DRT[1];
                        DIR_enable <= 1;
                        DIR_latch  <= 0;
						state      <= 4;
                    end
				4:
                    begin
                        DIR_serial <= DRT[2];
                        DIR_enable <= 1;
                        DIR_latch  <= 0;
						state      <= 5;
                    end
				5:
                    begin
                        DIR_serial <= ~DRT[2];
                        DIR_enable <= 1;
                        DIR_latch  <= 0;
						state      <= 6;
                    end
				6:
                    begin
                        DIR_serial <= DRT[3];
                        DIR_enable <= 1;
                        DIR_latch  <= 0;
						state      <= 7;
                    end
				7:
                    begin
                        DIR_serial <= ~DRT[3];
                        DIR_enable <= 1;
                        DIR_latch  <= 0;
						state      <= 8;
                    end 
				8:
                    begin 
                        DIR_enable <= 0;
                        DIR_latch  <= 1;
						state      <= 0;
				    end
				default:
					begin
						state      <= 0;
					end
            endcase
        end

endmodule


module divider(input clk_in,output reg clk_out);
    reg [32:0]count=0; 
    initial clk_out=0;
    always@(posedge clk_in)
        begin
            if(count<25000) 
                begin
                    count=count+1;
                end
            else
                begin
                    count=0;
                    clk_out=~clk_out;
                end
        end
         
endmodule

module PWM
(
    input Clk,
    input Reset,
    input [3:0]PWM_in,
    output reg  PWM_out
 );
    
    // Sets PWM Period.  Must be calculated vs. input clk period.
    // For example, setting this to 20 will divide the input clock by 2^20, or 1 Million.
    // So a 50 MHz input clock will be divided by 1e6, thus this will have a period of 1/50
    reg [31:0] DutyCycle = 1<<17;
    reg [20:0] count=0;
    always @(posedge Clk)
        if (!Reset)
            count <= 0;
        else
            count <= count + 1; 
    always @(PWM_in)
        DutyCycle = PWM_in<<17;
    always @(posedge Clk)
        if (count < DutyCycle)
            PWM_out <= 1'b0; 
        else
            PWM_out <= 1'b1; 
endmodule
	