`timescale 1ns / 1ps //time scale of 1 ns
module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk); //module as per fig 1
output [31:0] BusA, BusB; //since it is a word addressable we are having a 32 bit bus
input [31:0] BusW; //32 bit write bus
input [4:0] RA, RB, RW; //pins to select the register
input RegWr; //pin to enable writing. If RegWr is zero then writing is disabled.
input Clk; //input clock
reg [31:0] registers [31:0]; //32 registers of 32 bit each.
initial begin
registers[0] = 0; //register 0 is always used to store 0 and it should not be modified by the code.
end
assign #2 BusA = registers[RA]; //asynchronous assignment to the read bus.
assign #2 BusB = registers[RB];
always @ (negedge Clk) //writing only at the negative edge of the clock.
begin
if(RegWr) //writing only if it is enabled.
if (RW != 5'd0) //if the register to be written is the 0th register then we should not allow writing.
registers[RW] <= #3 BusW; //if other than 0th register, copy the contents of write bus in register
end
endmodule //end of module.