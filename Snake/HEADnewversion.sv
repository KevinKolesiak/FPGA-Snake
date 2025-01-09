
module  head ( input Reset, frame_clk,
					input [7:0] keycode, 
               output [9:0]  BallX, BallY, BallS, BallX2, BallY2, FoodX, FoodY);
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	int DistX, DistY, count;
	logic [9:0] Ball_X2_Pos, Ball_X2_Motion, Ball_Y2_Pos, Ball_Y2_Motion;
	logic [9:0] Food_X_Pos, Food_Y_Pos;
	 
	logic done, start, up , down, left, right; //active;
	 
    parameter [9:0] Ball_X_Center = 200;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 240;  // Center position on the Y axis
	parameter [9:0] Ball_X2_Center = 100;  // Center position on the X axis
    parameter [9:0] Ball_Y2_Center = 240;  // Center position on the Y axis
	parameter [9:0] Food_X_Center = 500;  // Center position on the X axis
    parameter [9:0] Food_Y_Center = 240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=2;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=2;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    
    assign Ball_Size = 50;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; 
			Ball_X_Motion <= 10'd0; 
			Ball_Y_Pos <= Ball_Y_Center;
			Ball_X_Pos <= Ball_X_Center;
			Food_Y_Pos <= Food_Y_Center;
			Food_X_Pos <= Food_X_Center;
			Ball_Y2_Motion <= 10'd0; 
			Ball_X2_Motion <= 10'd0; 
			Ball_Y2_Pos <= Ball_Y2_Center;
			Ball_X2_Pos <= Ball_X2_Center;
	
			done <= 0; //down <= 0; up <= 0; left <= 0; right <= 0;
			start <= 1;
        end
           
        else 
        begin //if(!active) ; 
				  
				 count <= count + 700;
				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )begin  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= 0; Ball_Y2_Motion <= 0; done = 1; end //(~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )begin  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= 0; Ball_Y2_Motion <= 0; done = 1;end //Ball_Y_Step;
					  
				 else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )begin  // Ball is at the Right edge, BOUNCE!
					  Ball_X_Motion <= 0; Ball_X2_Motion <= 0; done = 1;end // (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )begin  // Ball is at the Left edge, BOUNCE!
					  Ball_X_Motion <= 0; Ball_X2_Motion <= 0; done = 1;end //Ball_X_Step;
					  
				 else begin
				 case (keycode)
					8'h04 : begin

							if(!done && Ball_X_Motion==0)begin 
								Ball_X_Motion <= -4; Ball_Y_Motion<= 0; Ball_X2_Motion <= -4; Ball_Y2_Motion <= 0;
								Ball_X2_Pos <= Ball_X_Pos; Ball_Y2_Pos <= Ball_Y_Pos; start <= 0;//get old position
								end //A, left
							end
					        
					8'h07 : begin
								
					        if(!done && Ball_X_Motion ==0)begin 
								Ball_X_Motion <= 4; Ball_Y_Motion<= 0; Ball_X2_Motion <= 4; Ball_Y2_Motion <= 0;
								Ball_X2_Pos <= Ball_X_Pos; Ball_Y2_Pos <= Ball_Y_Pos; start <= 0;//get old position
								end //D, right
							  end

							  
					8'h16 : begin

					        if(!done && Ball_Y_Motion ==0)begin 
								Ball_X_Motion <= 0; Ball_Y_Motion<= 4; Ball_X2_Motion <= 0; Ball_Y2_Motion <= 4;
								Ball_X2_Pos <= Ball_X_Pos; Ball_Y2_Pos <= Ball_Y_Pos; start <= 0;//get old position
								end //S , down
							 end
							  
					8'h1A : begin
					        if(!done && Ball_Y_Motion ==0)begin 
								Ball_X_Motion <= 0; Ball_Y_Motion <= -4; Ball_X2_Motion <= 0; Ball_Y2_Motion <= -4;
								Ball_X2_Pos <= Ball_X_Pos; Ball_Y2_Pos <= Ball_Y_Pos; start <= 0;//get old position
								end //W , up
							 end	  
					default:
						begin
							Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  		Ball_X_Motion <= Ball_X_Motion;
							Ball_Y2_Motion <= Ball_Y2_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  		Ball_X2_Motion <= Ball_X2_Motion;
						end
			    endcase
				end
				 
				Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);	
				
				
				DistX <= Ball_X_Pos - Food_X_Pos; DistY <= Ball_Y_Pos - Food_Y_Pos; //move food
				if ( ( DistX*DistX + DistY*DistY) <= (Ball_Size * Ball_Size) ) begin
					Food_X_Pos <= ((count+Ball_X_Pos) % 490)+100; Food_Y_Pos <= ((count+Ball_Y_Pos) % 200)+100;
				end
				else begin
					Food_Y_Pos <= Food_Y_Pos;
					Food_X_Pos <= Food_X_Pos;
				end

				if (count % 20 == 1 && !start) begin
					   Ball_Y2_Pos <= Ball_Y_Pos; 
					   Ball_X2_Pos <= Ball_X_Pos; end 
					// Ball_Y2_Pos <= Ball_Y2_Pos + Ball_Y2_Motion;
					// Ball_X2_Pos <= Ball_X2_Pos + Ball_X2_Motion;  //end
				else begin
				Ball_Y2_Pos <= Ball_Y2_Pos+Ball_Y2_Motion; // move
				Ball_X2_Pos <= Ball_X2_Pos+Ball_X2_Motion; end
		end  
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;

	assign FoodX = Food_X_Pos;

	assign FoodY = Food_Y_Pos;
   
    assign BallS = Ball_Size;

	assign BallX2 = Ball_X2_Pos;
   
    assign BallY2 = Ball_Y2_Pos;
    

endmodule




// parameter [9:0] Ball_X_Step=50;      // Step size on the X axis
// parameter [9:0] Ball_Y_Step=50;      // Step size on the Y axis

				// if (down == 1) begin 
				// 	Ball_Y2_Pos <= Ball_Y_Pos-Ball_Size; Ball_X2_Pos <= Ball_X_Pos;  
				// end
				// else if(up == 1) begin
				// 	Ball_Y2_Pos <= Ball_Y_Pos+Ball_Size; Ball_X2_Pos <= Ball_X_Pos; up <= 0;
				// end
				// else if(left == 1) begin
				// 	Ball_Y2_Pos <= Ball_Y_Pos; Ball_X2_Pos <= Ball_X_Pos+Ball_Size; left <= 0;
				// end
				// else if(right == 1) begin
				// 	Ball_Y2_Pos <= Ball_Y_Pos; Ball_X2_Pos <= Ball_X_Pos-Ball_Size; right <= 0;
				// end
                