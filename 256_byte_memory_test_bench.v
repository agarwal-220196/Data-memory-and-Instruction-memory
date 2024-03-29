`timescale 1ns / 1ps //timescale of 1 ns
`define STRLEN 32
module DataMemoryTest_v; //name of testbench module name.
task passTest; //task to check the expected output and actual output.
input [31:0] actualOut, expectedOut;
input [`STRLEN*8:0] testType;
inout [7:0] passed;
if(actualOut == expectedOut) begin
$display ("%s passed", testType); passed = passed + 1;
end
else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
endtask
task allPassed; //task to check if all test cases passed.
input [7:0] passed;
input [7:0] numTests;
if(passed == numTests) $display ("All tests passed");
else $display("Some tests failed");
endtask
// Inputs
reg [31:0] Address;
reg [31:0] WriteData;
reg MemoryRead;
reg MemoryWrite;
reg Clock;
reg [7:0] passed;
//intermediate nets
wire [5:0] MemAddress;
// Outputs
wire [31:0] ReadData;
assign MemAddress = Address[7:2]; //left shifting the bits by 2 location.
// Instantiate the Unit Under Test (UUT)
DataMemory uut (
ReadData,
MemAddress,
WriteData,
MemoryRead,
MemoryWrite,
Clock
);
initial begin
// Initialize Inputs
Address = 0;
WriteData = 0;
MemoryRead = 0;
MemoryWrite = 0;
Clock = 0;
passed = 0;
// writing data into different locations of memory.
$display("Init Memory with some useful data");
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'h0, 32'h4, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'h4, 32'h3, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'h8, 32'd50, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'hc, 32'd40, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'h10, 32'd30, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'h14, 32'h0, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'h20, 32'h0, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'h78, 32'h132, 2'h2};#50 Clock =0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'h80, 32'd16435934, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'hc8, 32'haaaaffff, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'hcc, 32'd1431699200, 2'h2};#50 Clock = 0;
#50 Clock = 1;{Address, WriteData, MemoryWrite, MemoryRead} = {32'hf0, 32'hffff0000, 2'h2};#50 Clock = 0;
/*reading the data written above and checking it with the expected outputs */
#50 Clock = 1;
{Address, WriteData, MemoryWrite, MemoryRead} = {32'h14, 32'hffff0000, 2'h1};
#50 Clock = 0;
#50 Clock = 1;
passTest(ReadData, 32'h0, "Read address 0x14", passed);
{Address, WriteData, MemoryWrite, MemoryRead} = {32'hf0, 32'hffff0000, 2'h1};
#50 Clock = 0;
#50 Clock = 1;
passTest(ReadData, 32'hffff0000, "Read address 0xf0", passed);
{Address, WriteData, MemoryWrite, MemoryRead} = {32'hcc, 32'hffff0000, 2'h1};
#50 Clock = 0;
#50 Clock = 1;
passTest(ReadData, 32'd1431699200, "Read address 0xcc", passed);
{Address, WriteData, MemoryWrite, MemoryRead} = {32'hc8, 32'hffff0000, 2'h1};
#50 Clock = 0;
#50 Clock = 1;
passTest(ReadData, 32'haaaaffff, "Read address 0xc8", passed);
{Address, WriteData, MemoryWrite, MemoryRead} = {32'hc, 32'hffff0000, 2'h1};
#50 Clock = 0;
#50 Clock = 1;
passTest(ReadData, 32'd40, "Read address 0xc", passed);
allPassed(passed, 5);
end
endmodule //end of module