`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2024 10:39:02
// Design Name: 
// Module Name: sumador
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//Módulo sumador
module sumador #(parameter Width = 8)(
  output [Width-1:0] result,
  input [Width-1:0] a, 
  input [Width-1:0] b
);
    assign result = a + b;
endmodule
