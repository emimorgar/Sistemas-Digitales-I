`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 17:26:34
// Design Name: 
// Module Name: tb_compuertas
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
module semaforo_tb#(parameter WIDTH = 3);

    logic mtm;
    logic [WIDTH-1:0] ctrl;
    logic Rl, Yl, Gl;
    
    bit clk;
    
    semaforo DUT(
        .mtm(mtm),
        .ctrl(ctrl),
        .Rl(Rl),
        .Yl(Yl),
        .Gl(Gl)
    );
    
    always #10 clk = !clk;  // Ciclo de reloj
    
    initial begin
        clk = 0;
        mtm = 0;
        ctrl = 3'b000;
        
        #10;
        
        repeat(5)@(posedge clk)begin
        $display("Luz Roja: %b, Luz Amarilla: %b, Luz Verde: %b", Rl, Yl, Gl);   
        end
        
        mtm=1;
        ctrl = 3'b110;
                
        repeat(2)@(posedge clk) begin
        $display("Luz Roja: %b, Luz Amarilla: %b, Luz Verde: %b", Rl, Yl, Gl); 
        end
        
        ctrl = 3'b111;
        
        repeat(2)@(posedge clk) begin
        $display("Luz Roja: %b, Luz Amarilla: %b, Luz Verde: %b", Rl, Yl, Gl); 
        end       
        
        mtm=0;
        repeat(20)@(posedge clk) begin
        $display("Luz Roja: %b, Luz Amarilla: %b, Luz Verde: %b", Rl, Yl, Gl);
        end;       
    end
    
endmodule
