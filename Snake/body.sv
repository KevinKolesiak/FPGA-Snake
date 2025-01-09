

// module  body ( input Reset, frame_clk, delay,
// 					input [7:0] keycode, 
// 					input [9:0] startX, startY, followX, followY,
//                output [9:0]  bodyX, bodyY);
    
//     logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size, diff;
	 
// 	 logic done; //active;
	 
//     logic [9:0] Ball_X_Center; //= 50;  // Center position on the X axis
//     logic [9:0] Ball_Y_Center; //= 240;  // Center position on the Y axis
//     parameter [9:0] Ball_X_Min=5;       // Leftmost point on the X axis
//     parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
//     parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
//     parameter [9:0] Ball_Y_Max=469;     // Bottommost point on the Y axis
//     parameter [9:0] Ball_X_Step=50;      // Step size on the X axis
//     parameter [9:0] Ball_Y_Step=50;      // Step size on the Y axis
	 
//     assign diff = 20;
// 	 assign Ball_X_Center = startX;
// 	 assign Ball_Y_center = startY;
//     assign Ball_Size = 10;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
//     always_ff @ (posedge Reset or posedge frame_clk )
//     begin: Move_Ball
//         if (Reset)  // Asynchronous Reset
//         begin 
//             Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
// 				Ball_X_Motion <= 10'd0; //Ball_X_Step;
// 				Ball_Y_Pos <= followY; //Ball_Y_Center;
// 				Ball_X_Pos <= followX-2*Ball_Size; //Ball_X_Center;
// 				done = 0;
//         end
           
//         else 
//         begin       
//             if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )begin  // Ball is at the bottom edge, BOUNCE!
// 				Ball_Y_Motion <= 0; done = 1; end //(~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
// 			else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )begin  // Ball is at the top edge, BOUNCE!
// 				Ball_Y_Motion <= 0; done = 1;end //Ball_Y_Step;
					  
// 			else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )begin  // Ball is at the Right edge, BOUNCE!
// 				Ball_X_Motion <= 0; done = 1;end // (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  
// 			else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )begin  // Ball is at the Left edge, BOUNCE!
// 				Ball_X_Motion <= 0; done = 1;end //Ball_X_Step;
            
//             else begin
//                 case (keycode)
// 					8'h04 : begin
// 								if(!done && Ball_X_Motion==0)begin 
//                                     Ball_X_Pos <= (followX+2*Ball_Size); Ball_Y_Pos <= followY;
//                                     Ball_X_Motion <= -4; Ball_Y_Motion<= 0; end //A, left
// 							    end
					        
// 					8'h07 : begin
								
// 					        if(!done && Ball_X_Motion ==0)begin 
//                                 Ball_X_Pos <= (followX-2*Ball_Size); Ball_Y_Pos <= followY;
//                                 Ball_X_Motion <= 4; Ball_Y_Motion<= 0;end //D, right
// 							end

							  
// 					8'h16 : begin

// 					        if(!done && Ball_Y_Motion ==0)begin 
//                                 Ball_X_Pos <= followX; Ball_Y_Pos <= (followY-2*Ball_Size);
//                                 Ball_X_Motion <= 0; Ball_Y_Motion<= 4;end //S , down
// 							end
							  
// 					8'h1A : begin
// 					        if(!done && Ball_Y_Motion ==0)begin
//                                 Ball_X_Pos <= followX; Ball_Y_Pos <= (followY+2*Ball_Size); 
//                                 Ball_X_Motion <= 0; Ball_Y_Motion<= -4;end //W , up
// 							end	  
// 					default:
// 						begin
// 							Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, just keep moving
// 					  		Ball_X_Motion <= Ball_X_Motion;
// 						end
// 			    endcase
            
//             end
				 
// 			Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
// 			Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
				
// 		end  
//     end
       
//     assign bodyX = Ball_X_Pos;
   
//     assign bodyY = Ball_Y_Pos;
   
//     //assign BallS = Ball_Size;
    

// endmodule


// // if(((followX-2*Ball_Size-Ball_X_Pos) > 0)&&(Ball_Y_Pos==followY))begin Ball_X_Motion <= 4; Ball_Y_Motion <= 0; end  //follow right       
//             // else if((followX-2*Ball_Size-Ball_X_Pos) < 0)begin Ball_X_Motion <= -4; Ball_Y_Motion <= 0; end  //follow left				
// 			// // else begin Ball_X_Motion <= 0; Ball_Y_Motion <= 0; end

//             // if((followY == Ball_Y_Pos))begin Ball_Y_Motion <= 0; Ball_Y_Motion <= 0; end  //nothing
//             // else if((followY-Ball_Y_Pos) > 0)begin Ball_X_Motion <= 0; Ball_Y_Motion <= 4; end  //follow down	   
//             // else if((followY-Ball_Y_Pos) < 0)begin Ball_X_Motion <= 0; Ball_Y_Motion <= -4; end  //follow up	


//             // case (keycode)
// 			// 		8'h04 : begin

// 			// 					if(!done && Ball_X_Motion==0)begin 
                                    
//             //                         for(int i=0; i<4000; i++) begin end //delay
//             //                         Ball_X_Motion <= -4; Ball_Y_Motion<= 0;end //A, left
// 			// 				  end
					        
// 			// 		8'h07 : begin
								
// 			// 		        if(!done && Ball_X_Motion ==0)begin 
//             //                     for(int i=0; i<4000; i++) begin end //delay
//             //                     Ball_X_Motion <= 4; Ball_Y_Motion<= 0;end //D, right
// 			// 				  end

							  
// 			// 		8'h16 : begin

// 			// 		        if(!done && Ball_Y_Motion ==0)begin 
//             //                     for(int i=0; i<4000; i++) begin end //delay
//             //                     Ball_X_Motion <= 0; Ball_Y_Motion<= 4;end //S , down
// 			// 				 end
							  
// 			// 		8'h1A : begin
// 			// 		        if(!done && Ball_Y_Motion ==0)begin 
//             //                     for(int i=0; i<4000; i++) begin end //delay
//             //                     Ball_X_Motion <= 0; Ball_Y_Motion<= -4;end //W , up
// 			// 				 end	  
// 			// 		default:
// 			// 			begin
// 			// 				Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
// 			// 		  		Ball_X_Motion <= Ball_X_Motion;
// 			// 			end
// 			//    endcase