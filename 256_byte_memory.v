`timescale 1ns / 1ps //time scale of 1 ns
module DataMemory (
output reg [31:0] read_data, // Memory Address Contents to be read
input wire [5:0] addr, // Memory Address
input wire [31:0] write_data, // Memory Address Contents to be written
input wire memread, //enable signals
input wire memwrite,
input wire clk
);
reg [31:0] MEMO[0:63]; // 64 registers of 32-bit memory
always @(negedge clk) begin //writing at the negative edge of clock
if (memwrite == 1'b1) begin //checking if enable signal is high or not.
MEMO[addr] <= write_data; //saving the data on write bus in the memory
end
end
always @(posedge clk) begin //reading only at the positive edge of clock
if (memread == 1'b1) begin //checking the enable signal.
read_data <= MEMO[addr];
end
end
endmodule