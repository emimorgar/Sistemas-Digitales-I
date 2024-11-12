`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2024 10:42:51
// Design Name: 
// Module Name: tb_sumador
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

module tb_sumador;
  parameter ADDER_WIDTH = 8;
 
  adder_intf #(ADDER_WIDTH) adder_intf_i(); // Creamos la instancia de la interface
 
  sumador #(ADDER_WIDTH /* Pre-synthesis */) DUT (
      .result(adder_intf_i.result), // conectamos el puerto result del DUT con la variable result de la instancia de la interface
      .a(adder_intf_i.a),
      .b(adder_intf_i.b)
  );
  
   //`define TEST1
   //`define TEST2
   //`define TEST3
   `define TEST4
   //`define TEST5
 
  `ifdef TEST1
    initial begin
      adder_intf_i.add_a_b_random();
      #1;
      $display("Resultado: %b", adder_intf_i.result);
      $finish;
    end
  `endif
 
  `ifdef TEST2
    initial begin
      adder_intf_i.add_a_zero_b_random();
      #1;
      $display("Resultado: %b", adder_intf_i.result);
      repeat (10) begin
        adder_intf_i.add_a_b_random();
        #1;
        $display("Resultado: %b", adder_intf_i.result);
      end
      adder_intf_i.add_a_b_zero();
      #1;
      $display("Resultado: %b", adder_intf_i.result);
      $finish;
    end
  `endif
  
  `ifdef TEST3
    // Test 3 - 
    ///////////////////////////////////////////////////////////////
    // 1. adds "a" plus "b" when both have their max value possible  //
    ///////////////////////////////////////////////////////////////
    initial begin
      adder_intf_i.add_a_b_max();
      #1;
      $display("Resultado: %b", adder_intf_i.result);
      $finish;
    end
  `endif
  
  `ifdef TEST4
    // Test 4 - 
    ///////////////////////////////////////////////////////////////
    // 1. alternates the value of a(10101010) and b(01010101),   //
    //    and then add both of them.                             //
    ///////////////////////////////////////////////////////////////
    initial begin
      adder_intf_i.add_a_b_alternate();
      #1;
      $display("Resultado: %b", adder_intf_i.result);
      $finish;
    end
  `endif
  
  `ifdef TEST5
    // Test 5 - 
    //////////////////////////////////////////////
    // 1. adds intermediate values a=128, b=127 //
    // 2. adds intermediate values a=127, b=128 // 
    // 3. b has max value, b adds 1             //
    //////////////////////////////////////////////
    initial begin
      adder_intf_i.add_a_b_intermediate();
      #1;
      $display("Resultado: %b", adder_intf_i.result);
      adder_intf_i.add_b_a_intermediate();
      #1;
      $display("Resultado: %b", adder_intf_i.result);
      adder_intf_i.add_a_b_overflow();
      #1;
      $display("Resultado: %b", adder_intf_i.result);
      $finish;
    end
  `endif
   
  initial begin 
   $dumpfile("filel.vcd");
   $dumpvars;
  end
endmodule: tb_sumador

interface adder_intf #(parameter WIDTH = 8 /* Pre-synthesis */) ();
 
  bit [WIDTH-1:0] a;
  bit [WIDTH-1:0] b;
  logic [WIDTH-1:0] result;
  // BFM - Bus Functional Model // Conjunto de tasks & functions que permiten generar estimulos
  // validos para el DUT
  
  //This function adds a random number (b) to 0 (a)
  function add_a_zero_b_random();
    a = '0;
    std::randomize(b);
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction
  
  //This function adds a random number (a) to 0 (b)
  function add_b_zero_a_random();
    b = '0;
    std::randomize(a);
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction
  
  //This function adds two random  numbers.
  function add_a_b_random();
    std::randomize(a);
    std::randomize(b);
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction
 
  // This function can be used for adding two numbers a/b with a value of zero
  function add_a_b_zero();
    a = '0;
    b = '0;
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction
  
  //This function adds a plus b when both have their max value possible
  function add_a_b_max();
    a = 8'b11111111;
    b = 8'b11111111;    
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction
  
  //This function alternates the value of a(10101010) and b(01010101), and then add both of them
  function add_a_b_alternate();
    a = 8'b10101010;
    b = 8'b01010101;    
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction 
  
  //This function adds intermediate values
  function add_a_b_intermediate();
    a = 127;
    b = 128;    
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction
   
  function add_b_a_intermediate();
    a = 128;
    b = 127;    
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction
  
  function add_a_b_overflow();
    a = 1;
    b = 255;    
    $display("a: %b", a);
    $display("b: %b", b);
  endfunction
  
endinterface: adder_intf
 

