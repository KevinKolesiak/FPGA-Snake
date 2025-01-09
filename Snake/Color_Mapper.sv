//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size, BallX2, BallY2, FoodX, FoodY, 
                                          BallX3, BallY3, BallX4, BallY4, BallX5, BallY5, BallX6, BallY6, BallX7, BallY7,
                                          BallX8, BallY8, BallX9, BallY9, BallX10, BallY10, BallX11, BallY11, 
                                          BallX12, BallY12, BallX13, BallY13, BallX14, BallY14, BallX15, BallY15, 
                                          BallX16, BallY16, BallX17, BallY17, BallX18, BallY18, BallX19, BallY19, //BallX1, BallY1, */
                       input blank,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on, ball_on2, food_on, ball_on3, ball_on4, ball_on5, ball_on6, ball_on7, ball_on8, ball_on9, ball_on10,
          ball_on11, ball_on12, ball_on13, ball_on14, ball_on15, ball_on16, ball_on17, ball_on18, ball_on19; ////*/
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). 
 */  
    int DistX, DistY, DistX2, DistY2, Size, DistXF, DistYF, DistX3, DistY3, DistX4, DistY4, DistX5, DistY5, DistX6, 
        DistY6, DistX7, DistY7, DistX8, DistY8, DistX9, DistY9, DistX10, DistY10, DistX11, DistY11, 
        DistX12, DistY12, DistX13, DistY13, DistX14, DistY14, DistX15, DistY15, DistX16, DistY16, DistX17, DistY17, 
        DistX18, DistY18, DistX19, DistY19; //, DistX1, DistY1,     ////*/////
	assign DistX = DrawX - BallX; assign DistY = DrawY - BallY;  assign Size = Ball_size;
    assign DistXF = DrawX - FoodX; assign DistYF = DrawY - FoodY; assign DistX2 = DrawX - BallX2; assign DistY2 = DrawY - BallY2; 
    assign DistX3 = DrawX - BallX3; assign DistY3 = DrawY - BallY3;assign DistX4 = DrawX - BallX4; assign DistY4 = DrawY - BallY4; ////
    assign DistX5 = DrawX - BallX5; assign DistY5 = DrawY - BallY5;assign DistX6 = DrawX - BallX6; assign DistY6 = DrawY - BallY6;
	assign DistX7 = DrawX - BallX7; assign DistY7 = DrawY - BallY7;assign DistX8 = DrawX - BallX8;assign DistY8 = DrawY - BallY8;
    assign DistX9 = DrawX - BallX9;assign DistY9 = DrawY - BallY9;assign DistX10 = DrawX - BallX10;assign DistY10 = DrawY - BallY10;
    assign DistX11 = DrawX - BallX11;assign DistY11 = DrawY - BallY11;assign DistX12 = DrawX - BallX12;assign DistY12 = DrawY - BallY12;
    assign DistX13 = DrawX - BallX13;assign DistY13 = DrawY - BallY13;assign DistX14 = DrawX - BallX14;assign DistY14 = DrawY - BallY14;
    assign DistX15 = DrawX - BallX15;assign DistY15 = DrawY - BallY15;assign DistX16 = DrawX - BallX16;assign DistY16 = DrawY - BallY16;
    assign DistX17 = DrawX - BallX17;assign DistY17 = DrawY - BallY17;assign DistX18 = DrawX - BallX18;assign DistY18 = DrawY - BallY18;
    assign DistX19 = DrawX - BallX19;assign DistY19 = DrawY - BallY19;//assign DistX1 = DrawX - BallX1;assign DistY1 = DrawY - BallY1;*/  

    always_comb
    begin:Ball_on_proc
        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            ball_on = 1'b1;
         else 
            ball_on = 1'b0;		
		if ( ( DistX2*DistX2 + DistY2*DistY2) <= (Size * Size) ) 
            ball_on2 = 1'b1;
         else 
            ball_on2 = 1'b0;
        if ( ( DistXF*DistXF + DistYF*DistYF) <= (Size * Size) ) 
            food_on = 1'b1;
         else 
            food_on = 1'b0;
        if ( ( DistX3*DistX3 + DistY3*DistY3) <= (Size * Size) ) 
            ball_on3 = 1'b1;
         else 
            ball_on3 = 1'b0;      
        if ( ( DistX4*DistX4 + DistY4*DistY4) <= (Size * Size) ) 
            ball_on4 = 1'b1;
         else 
            ball_on4 = 1'b0;
        if ( ( DistX5*DistX5 + DistY5*DistY5) <= (Size * Size) ) 
            ball_on5 = 1'b1;
         else 
            ball_on5 = 1'b0;
        if ( ( DistX6*DistX6 + DistY6*DistY6) <= (Size * Size) ) 
            ball_on6 = 1'b1;
         else 
            ball_on6 = 1'b0;
        if ( ( DistX7*DistX7 + DistY7*DistY7) <= (Size * Size) ) 
            ball_on7 = 1'b1;
         else 
            ball_on7 = 1'b0;	
        if ( ( DistX8*DistX8 + DistY8*DistY8) <= (Size * Size) ) 
            ball_on8 = 1'b1;
         else 
            ball_on8 = 1'b0;	
        if ( ( DistX9*DistX9 + DistY9*DistY9) <= (Size * Size) ) 
            ball_on9 = 1'b1;
         else 
            ball_on9 = 1'b0;	
        if ( ( DistX10*DistX10 + DistY10*DistY10) <= (Size * Size) ) 
            ball_on10 = 1'b1;
         else 
            ball_on10 = 1'b0;	
        if ( ( DistX11*DistX11 + DistY11*DistY11) <= (Size * Size) ) 
            ball_on11 = 1'b1;
         else 
            ball_on11 = 1'b0;
        if ( ( DistX12*DistX12 + DistY12*DistY12) <= (Size * Size) ) 
            ball_on12 = 1'b1;
         else 
            ball_on12 = 1'b0;
        if ( ( DistX13*DistX13 + DistY13*DistY13) <= (Size * Size) ) 
            ball_on13 = 1'b1;
         else 
            ball_on13 = 1'b0;
        if ( ( DistX14*DistX14 + DistY14*DistY14) <= (Size * Size) ) 
            ball_on14 = 1'b1;
         else 
            ball_on14 = 1'b0;
        if ( ( DistX15*DistX15 + DistY15*DistY15) <= (Size * Size) ) 
            ball_on15 = 1'b1;
         else 
            ball_on15 = 1'b0;		
        if ( ( DistX16*DistX16 + DistY16*DistY16) <= (Size * Size) ) 
            ball_on16 = 1'b1;
         else 
            ball_on16 = 1'b0;
        if ( ( DistX17*DistX17 + DistY17*DistY17) <= (Size * Size) ) 
            ball_on17 = 1'b1;
         else 
            ball_on17 = 1'b0;
        if ( ( DistX18*DistX18 + DistY18*DistY18) <= (Size * Size) ) 
            ball_on18 = 1'b1;
         else 
            ball_on18 = 1'b0;
        if ( ( DistX19*DistX19 + DistY19*DistY19) <= (Size * Size) ) 
            ball_on19 = 1'b1;
         else 
            ball_on19 = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
        if(blank == 1'b0) begin
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'h00;
         end   
        else if ((ball_on == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end       	  
		else if ((ball_on2 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end
		else if ((food_on == 1'b1)) begin
			Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
         end
        else if ((ball_on3 == 1'b1)) begin 
             Red = 8'h00;
             Green = 8'h00;
             Blue = 8'hff;
         end
        else if ((ball_on4 == 1'b1)) begin 
             Red = 8'h00;
             Green = 8'h00;
             Blue = 8'hff;
         end
        else if ((ball_on5 == 1'b1)) begin 
             Red = 8'h00;
             Green = 8'h00;
             Blue = 8'hff;
         end
        else if ((ball_on6 == 1'b1)) begin 
             Red = 8'h00;
             Green = 8'h00;
             Blue = 8'hff;
         end
        else if ((ball_on7 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on8 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on9 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on10 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on11 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on12 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on13 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on14 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on15 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on16 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end 
        else if ((ball_on17 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end   
		else if ((ball_on18 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else if ((ball_on19 == 1'b1)) begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
         end  
        else begin 
			Red = 8'h00; 
            Green = 8'h7f-DrawY[9:3]; //-DrawX[9:3]
            Blue = 8'h00;
         end      
    end 
    
endmodule
