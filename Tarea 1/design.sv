//AND module with three inputs

module bitwise_and #(parameter WIDTH = 4) (
  input wire [WIDTH-1:0] a, b, c,
  output reg [WIDTH-1:0] and_out
);
  assign and_out=a & b & c;
endmodule