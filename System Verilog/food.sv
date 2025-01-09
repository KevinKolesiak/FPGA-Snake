

module  food ( input Reset, frame_clk,
					     input [9:0] headX, headY,
               output [9:0]  fruitX, fruitY);
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 
	  //logic done; //active;
	 
    parameter [9:0] Ball_X_Center = 500;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center; = 240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=5;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=469;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=50;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=50;      // Step size on the Y axis
	 
    assign Ball_Size = 10;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= startY; //Ball_Y_Center;
				Ball_X_Pos <= startX; //Ball_X_Center;
				done = 0;
        end
           
        else 
        begin 
          if(Ball_X_Pos == headX && Ball_Y_Pos == headY) begin 
            Ball_X_Pos <= (frame_clk % 600)+40; Ball_Y_Pos <= (frame_clk % 400)+40;

          end
			
		    end  
    end
       
    assign foodX = Ball_X_Pos;
   
    assign foodY = Ball_Y_Pos;
   
    //assign BallS = Ball_Size;
    

endmodule
