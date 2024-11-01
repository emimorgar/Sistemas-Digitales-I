module testbench #(parameter WIDTH = 4) (
  output reg [WIDTH-1:0] and_out
);
  reg [WIDTH-1:0] a, b, c;
  reg clk = 1'b0;
  integer i=0;
  
  bitwise_and #(WIDTH) bit_and (		//AND module
    .a(a),
    .b(b),
    .c(c),
    .and_out(and_out)
	);	
  
  always @(posedge clk) begin //First process that checks for clk event and 
    i=i+1;					  //assigns random values to the inputs
    if(i<=5) begin  		  //Conditional to check for 5 clk positive edges
      a = $urandom;
      b = $urandom; 
      c = $urandom;
      #10;
      $write("C: %b \n", c); //Prints values C, B, A and then the result
      $write("B: %b \n", b);
      $write("A: %b \n", a);
      $write("Resultado: %b \n", and_out);
    end 
  end
  
  initial begin				//Second process that changes clk edges in a different 
    $dumpfile("dump.vcd");  //manner.
    $dumpvars;
    repeat (20) begin       //This process is repeated 20 times to check for 10
      clk = ~clk;			//positive clk edges.
      #10;
    end
    $finish;
  end
  
endmodule
