`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2024 14:47:13
// Design Name: 
// Module Name: semaforo
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

module semaforo #(parameter WIDTH = 3)(
//Declaración de variables   
    input logic mtm, //variable que activa modo mantenimiento
    input logic [WIDTH-1:0] ctrl, //Entradas que modifican las salidas si el sistema está en mantenimiento
    output logic Rl, Yl, Gl //Salidas Red Ligth, Yellow Light y Green Light
    );        
    
    reg clk = 0;
    logic [2:0]ctrl_red = 3'b011;    //variable que determina el tiempo de luz roja
    logic [2:0]ctrl_yell = 3'b001;   //variable que determina el tiempo de luz amarilla
    logic [2:0]ctrl_green = 3'b111; //variable que determina el tiempo de luz verde
    logic [2:0] c1=0, c2=0, c3=0; //Contadores para los ciclos de espera
    reg [3:0] state = 4'b0000; //Estados para loopear el semáforo
    reg s1=0, s2=0, s3=0;
    

    
    //Primer proceso para iniciar el semaforo en verde
    always @(posedge clk) begin
        if (s1) begin
         Rl <= 0;
         Yl <= 0;
         Gl <= 1;
         if(c1 < ctrl_green) begin
            c1 <= c1 + 1;
         end else begin
            s1 <= 0; 
            c1 <= 0;
         end      // Termina el proceso 1
        end
    end
    
    //Segundo proceso para poner el semaforo en amarillo
    always @(posedge clk) begin
        if (s2) begin
         Rl <= 0;
         Yl <= 1;
         Gl <= 0; 
         if(c2 < ctrl_yell) begin
            c2 <= c2 + 1;
         end else begin
            s2 <= 0; 
            c2 <= 0;
         end              
        end
    end
    
    //Tercer proceso para poner el semaforo en rojo
    always @(posedge clk) begin
        if (s3) begin
         Rl <= 1;
         Yl <= 0;
         Gl <= 0; 
         if(c3 < ctrl_red) begin
            c3 <= c3 + 1;
         end else begin
            s3 <= 0; 
            c3 <= 0;
         end       
        end
    end      
    
  // Maquina de estados para ciclar el semáforo
  always @(posedge clk) begin
    if (!mtm) begin
      case(state)
        4'b0000: begin
          s1 <= 0; 
          s2 <= 1;
          state <= 4'b0001;   
        end
        4'b0001: begin
          s2 <= 0;  
          s3 <= 1;  
          state <= 4'b0010;    
        end
        4'b0010: begin
          s3 <= 0;  
          s1 <= 1;  
          state <= 4'b0000;       
        end
        default: state <= 0;  
      endcase
    end else begin      // Si la señal de mantenimeinto esta activada 
        Rl <= ctrl[0];  // el control de las luces está dado por ctrl[] 
        Yl <= ctrl[1];
        Gl <= ctrl[2];
    end
  end
  
  always #10 clk = !clk;  // Ciclo de reloj
            
endmodule
