
module  snake ( input Reset, frame_clk,
					input [7:0] keycode, 
               output [9:0]  BallX, BallY, BallS, BallX2, BallY2, FoodX, FoodY, BallX3, BallY3, BallX4, BallY4, 
			   				BallX5, BallY5, BallX6, BallY6, BallX7, BallY7, BallX8, BallY8, BallX9, BallY9,
							BallX10, BallY10, BallX11, BallY11, BallX12, BallY12, BallX13, BallY13, BallX14, BallY14,
							BallX15, BallY15, BallX16, BallY16, BallX17, BallY17, BallX18, BallY18, BallX19, BallY19   //BallX20, //BallX1,   
							);
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size, Ball_X2_Pos, Ball_Y2_Pos,
				Food_X_Pos, Food_Y_Pos, Food_X_Pot, Food_Y_Pot, newFoodX, newFoodY;
	
	int DistXF, DistYF, DistXF2, DistYF2, DistX3, DistY3, DistX4, DistY4, DistX5, DistY5, DistX6, DistY6, DistX7, DistY7, DistX8, DistY8,
		DistX9, DistY9, DistX10, DistY10, DistX11, DistY11, DistX12, DistY12, DistX13, DistY13, DistX14, DistY14, 
		DistX15, DistY15, DistX16, DistY16, DistX17, DistY17, DistX18, DistY18, DistX19, DistY19, //, DistX1, DistY1, DistX1, DistY1, 
		count, countCol3, countCol4, countCol5, countCol6, countCol7, countCol8, countCol9, countCol10, countCol11, 
		countCol12, countCol13, countCol14, countCol15, countCol16, countCol17, countCol18, countCol19, //countCol20,    
		ranVal, active = 0;
	
	logic [9:0] Ball_X3_Pos, Ball_Y3_Pos, Ball_X4_Pos, Ball_Y4_Pos, Ball_X5_Pos, Ball_Y5_Pos, Ball_X6_Pos, Ball_Y6_Pos, 
				Ball_X7_Pos, Ball_Y7_Pos, Ball_X8_Pos, Ball_Y8_Pos, Ball_X9_Pos, Ball_Y9_Pos, Ball_X10_Pos, Ball_Y10_Pos,
				Ball_X11_Pos, Ball_Y11_Pos, Ball_X12_Pos, Ball_Y12_Pos, Ball_X13_Pos, Ball_Y13_Pos, Ball_X14_Pos, 
				Ball_Y14_Pos, Ball_X15_Pos, Ball_Y15_Pos, Ball_X16_Pos, Ball_Y16_Pos, Ball_X17_Pos, Ball_Y17_Pos, 
				Ball_X18_Pos, Ball_Y18_Pos, Ball_X19_Pos, Ball_Y19_Pos; //Ball_X1_Pos, Ball_Y1_Pos, ;    
	 
	logic done, start = 1; //up , down, left, right;
	logic won = 0;
	 
    parameter [9:0] Ball_X_Center = 145;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 240;  // Center position on the Y axis
	parameter [9:0] Ball_X2_Center = 55; parameter [9:0] Ball_Y2_Center = 240;  
	parameter [9:0] Food_X_Center = 500; parameter [9:0] Food_Y_Center = 240;
    parameter [9:0] Ball_X_Min=3;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=2;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    
    assign Ball_Size = 50;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0;Ball_X_Motion <= 10'd0;Ball_Y_Pos <= Ball_Y_Center;Ball_X_Pos <= Ball_X_Center;
			Food_Y_Pos <= Food_Y_Center;Food_X_Pos <= Food_X_Center;Ball_Y2_Pos <= Ball_Y2_Center;Ball_X2_Pos <= Ball_X2_Center;
			Ball_Y3_Pos <= Ball_Y_Center;Ball_X3_Pos <= Ball_X_Center;Ball_Y4_Pos <= Ball_Y_Center;Ball_X4_Pos <= Ball_X_Center; /////
			Ball_Y5_Pos <= Ball_Y_Center;Ball_X5_Pos <= Ball_X_Center;Ball_Y6_Pos <= Ball_Y_Center;Ball_X6_Pos <= Ball_X_Center;
			Ball_Y7_Pos <= Ball_Y_Center;Ball_X7_Pos <= Ball_X_Center;Ball_Y8_Pos <= Ball_Y_Center;Ball_X8_Pos <= Ball_X_Center;
			Ball_Y9_Pos <= Ball_Y_Center;Ball_X9_Pos <= Ball_X_Center; Ball_Y10_Pos <= Ball_Y_Center;Ball_X10_Pos <= Ball_X_Center;
			Ball_Y11_Pos <= Ball_Y_Center;Ball_X11_Pos <= Ball_X_Center;Ball_Y12_Pos <= Ball_Y_Center;Ball_X12_Pos <= Ball_X_Center;
			Ball_Y13_Pos <= Ball_Y_Center;Ball_X13_Pos <= Ball_X_Center;Ball_Y14_Pos <= Ball_Y_Center;Ball_X14_Pos <= Ball_X_Center;
			Ball_Y15_Pos <= Ball_Y_Center;Ball_X15_Pos <= Ball_X_Center;Ball_Y16_Pos <= Ball_Y_Center;Ball_X16_Pos <= Ball_X_Center;
			Ball_Y17_Pos <= Ball_Y_Center;Ball_X17_Pos <= Ball_X_Center;Ball_Y18_Pos <= Ball_Y_Center;Ball_X18_Pos <= Ball_X_Center;
			Ball_Y19_Pos <= Ball_Y_Center;Ball_X19_Pos <= Ball_X_Center; 
			
			done <= 0; start <= 1; count <=0; won <= 0; active <= 0; countCol3 <= 0; countCol4<=0; countCol5<=0; 
			countCol6<=0; countCol7<=0; countCol8<=0; countCol9<=0;countCol10<=0;countCol11<=0; countCol12<=0; 
			countCol13<=0; countCol14<=0; countCol15<=0; countCol16<=0; countCol17<=0; countCol18<=0; countCol19<=0;
         end
           
        else 
        begin
				count <= count + 1; ranVal <= (ranVal + 5); //(ranVal + 15)%600;
				if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )begin  // Ball is at the bottom edge
					Ball_Y_Motion <= 0; Ball_X_Motion <= 0; done <= 1; end	
				else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )begin  // Ball is at the top edge
					Ball_Y_Motion <= 0; Ball_X_Motion <= 0; done <= 1;end //Ball_Y2_Motion <= 0; Ball_Y_Step;	  
				else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )begin  // Ball is at the Right edge
					Ball_X_Motion <= 0; Ball_Y_Motion <= 0; done <= 1;end 	  
				else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )begin  // Ball is at the Left edge
					Ball_X_Motion <= 10'd0; Ball_Y_Motion <= 10'd0; done <= 1;end 	  
				else begin
				 case (keycode)
					8'h04 : begin
							if(!start && count % 5 == 1 && !done && Ball_X_Motion==0)begin 
								Ball_X_Motion <= -4; Ball_Y_Motion<= 0; start<=0;
								end //A, left
							end      
					8'h07 : begin
					        if(count % 5 == 1 && !done && Ball_X_Motion ==0)begin 
								Ball_X_Motion <= 4; Ball_Y_Motion<= 0; start<=0;
								end //D, right
							  end
					8'h16 : begin
					        if(count % 5 == 1 && !done && Ball_Y_Motion ==0)begin 
								Ball_X_Motion <= 0; Ball_Y_Motion<= 4; start<=0;
								end //S , down
							 end	  
					8'h1A : begin
					        if(count % 5 == 1 && !done && Ball_Y_Motion ==0)begin 
								Ball_X_Motion <= 0; Ball_Y_Motion <= -4; start<=0;
								end //W , up
							 end	  
					default:
						begin
							Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  		Ball_X_Motion <= Ball_X_Motion;
						end
			      endcase
					end
 
				Ball_Y_Pos<=(Ball_Y_Pos + Ball_Y_Motion);Ball_X_Pos<=(Ball_X_Pos + Ball_X_Motion);//Update ball position

				if(won) begin 
					done <= 1; Ball_X_Motion <= 0; Ball_Y_Motion <= 0;
					Food_X_Pos <= Ball_X_Pos; Food_Y_Pos <= Ball_Y_Pos;
				 end

				//code to collect food and spawn random: [try to make it not spawn close to snake or in it]
				DistXF <= Ball_X_Pos - Food_X_Pos; DistYF <= Ball_Y_Pos - Food_Y_Pos; 
				if (!won && (( DistXF*DistXF + DistYF*DistYF) <= (Ball_Size * Ball_Size))) begin  //move food
					//Food_X_Pos <= (((Ball_X_Pos+(ranVal%100+50)+200) % 490))+100; Food_Y_Pos <= ((Ball_Y_Pos+(ranVal%100+50)) % 200)+100;
					// Food_X_Pot <= ((ranVal % 490))+100; Food_Y_Pot <= (ranVal % 200)+100; 
					Food_X_Pos <= ((ranVal % 490))+100; Food_Y_Pos <= (ranVal % 200)+100; 

					// DistXF2 <= Food_X_Pos-Food_X_Pot; DistYF2 <= Food_Y_Pos-Food_Y_Pot;
					// if((DistXF2*DistXF2 + DistYF2*DistYF2) >= (4*Ball_Size * Ball_Size)) begin
					// 	Food_X_Pos <= Food_X_Pot; Food_Y_Pos <= Food_Y_Pot; 
					// 	 end
					// else begin 
					// 	Food_X_Pos <= ((ranVal+100)%490)+100; Food_Y_Pos <= ((ranVal+50)%200)+100;
					// 	 end
					active <= active+1; 
				end
				else if (won) begin 
					Food_X_Pos <= Ball_X_Pos; Food_Y_Pos <= Ball_Y_Pos; 
				end
				else begin
					Food_Y_Pos <= Food_Y_Pos; Food_X_Pos <= Food_X_Pos; 
				end
				
				if (count % 24 == 1 && !done && !start) begin	//adding balls + collision detection, clocked
					Ball_Y2_Pos <= Ball_Y_Pos; Ball_X2_Pos <= Ball_X_Pos; //follow		 
					if(active>0) begin
						Ball_Y3_Pos <= Ball_Y2_Pos; Ball_X3_Pos <= Ball_X2_Pos; //follow
						
						DistX3 <= Ball_X_Pos - Ball_X3_Pos; DistY3 <= Ball_Y_Pos - Ball_Y3_Pos;//collision detect  
						if(( DistX3*DistX3 + DistY3*DistY3) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol3 <= countCol3+1;
							if(countCol3 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0;
								end
							end
						end
					if(active>2) begin 
						Ball_Y4_Pos <= Ball_Y3_Pos; Ball_X4_Pos <= Ball_X3_Pos; //follow
						
						DistX4 <= Ball_X_Pos - Ball_X4_Pos; DistY4 <= Ball_Y_Pos - Ball_Y4_Pos;//collision detect
						if(( DistX4*DistX4 + DistY4*DistY4) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol4 <= countCol4+1;
							if(countCol4 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>4) begin 
						Ball_Y5_Pos <= Ball_Y4_Pos; Ball_X5_Pos <= Ball_X4_Pos; //follow
						
						DistX5 <= Ball_X_Pos - Ball_X5_Pos; DistY5 <= Ball_Y_Pos - Ball_Y5_Pos;//collision detect
						if(( DistX5*DistX5 + DistY5*DistY5) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol5 <= countCol5+1;
							if(countCol5 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end					
					if(active>6) begin 
						Ball_Y6_Pos <= Ball_Y5_Pos; Ball_X6_Pos <= Ball_X5_Pos; //follow
						
						DistX6 <= Ball_X_Pos - Ball_X6_Pos; DistY6 <= Ball_Y_Pos - Ball_Y6_Pos;//collision detect
						if(( DistX6*DistX6 + DistY6*DistY6) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol6 <= countCol6+1;
							if(countCol6 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>8) begin 
						Ball_Y7_Pos <= Ball_Y6_Pos; Ball_X7_Pos <= Ball_X6_Pos; //follow
						
						DistX7 <= Ball_X_Pos - Ball_X7_Pos; DistY7 <= Ball_Y_Pos - Ball_Y7_Pos;//collision detect
						if(( DistX7*DistX7 + DistY7*DistY7) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol7 <= countCol7+1;
							if(countCol7 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>10) begin 
						Ball_Y8_Pos <= Ball_Y7_Pos; Ball_X8_Pos <= Ball_X7_Pos; //follow
						
						DistX8 <= Ball_X_Pos - Ball_X8_Pos; DistY8 <= Ball_Y_Pos - Ball_Y8_Pos;//collision detect
						if(( DistX8*DistX8 + DistY8*DistY8) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol8 <= countCol8+1;
							if(countCol8 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end	
					if(active>12) begin 
						Ball_Y9_Pos <= Ball_Y8_Pos; Ball_X9_Pos <= Ball_X8_Pos; //follow
						
						DistX9 <= Ball_X_Pos - Ball_X9_Pos; DistY9 <= Ball_Y_Pos - Ball_Y9_Pos;//collision detect
						if(( DistX9*DistX9 + DistY9*DistY9) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol9 <= countCol9+1;
							if(countCol9 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>14) begin 
						Ball_Y10_Pos <= Ball_Y9_Pos; Ball_X10_Pos <= Ball_X9_Pos; //follow
						
						DistX10 <= Ball_X_Pos - Ball_X10_Pos; DistY10 <= Ball_Y_Pos - Ball_Y10_Pos;//collision detect
						if(( DistX10*DistX10 + DistY10*DistY10) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol10 <= countCol10+1;
							if(countCol10 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>16) begin 
						Ball_Y11_Pos <= Ball_Y10_Pos; Ball_X11_Pos <= Ball_X10_Pos; //follow
						
						DistX11 <= Ball_X_Pos - Ball_X11_Pos; DistY11 <= Ball_Y_Pos - Ball_Y11_Pos;//collision detect
						if(( DistX11*DistX11 + DistY11*DistY11) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol11 <= countCol11+1;
							if(countCol11 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>18) begin 
						Ball_Y12_Pos <= Ball_Y11_Pos; Ball_X12_Pos <= Ball_X11_Pos; //follow
						
						DistX12 <= Ball_X_Pos - Ball_X12_Pos; DistY12 <= Ball_Y_Pos - Ball_Y12_Pos;//collision detect
						if(( DistX12*DistX12 + DistY12*DistY12) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol12 <= countCol12+1;
							if(countCol12 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>20) begin 
						Ball_Y13_Pos <= Ball_Y12_Pos; Ball_X13_Pos <= Ball_X12_Pos; //follow
						
						DistX13 <= Ball_X_Pos - Ball_X13_Pos; DistY13 <= Ball_Y_Pos - Ball_Y13_Pos;//collision detect
						if(( DistX13*DistX13 + DistY13*DistY13) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol13 <= countCol13+1;
							if(countCol13 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>22) begin 
						Ball_Y14_Pos <= Ball_Y13_Pos; Ball_X14_Pos <= Ball_X13_Pos; //follow
						//won <= 1;
						DistX14 <= Ball_X_Pos - Ball_X14_Pos; DistY14 <= Ball_Y_Pos - Ball_Y14_Pos;//collision detect
						if(( DistX14*DistX14 + DistY14*DistY14) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol14 <= countCol14+1;
							if(countCol14 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>24) begin 
						Ball_Y15_Pos <= Ball_Y14_Pos; Ball_X15_Pos <= Ball_X14_Pos; //follow
						
						DistX15 <= Ball_X_Pos - Ball_X15_Pos; DistY15 <= Ball_Y_Pos - Ball_Y15_Pos;//collision detect
						if(( DistX15*DistX15 + DistY15*DistY15) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol15 <= countCol15+1;
							if(countCol15 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>26) begin 
						Ball_Y16_Pos <= Ball_Y15_Pos; Ball_X16_Pos <= Ball_X15_Pos; //follow
						
						DistX16 <= Ball_X_Pos - Ball_X16_Pos; DistY16 <= Ball_Y_Pos - Ball_Y16_Pos;//collision detect
						if(( DistX16*DistX16 + DistY16*DistY16) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol16 <= countCol16+1;
							if(countCol16 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>28) begin 
						Ball_Y17_Pos <= Ball_Y16_Pos; Ball_X17_Pos <= Ball_X16_Pos; //follow
						won <= 1;
						DistX17 <= Ball_X_Pos - Ball_X17_Pos; DistY17 <= Ball_Y_Pos - Ball_Y17_Pos;//collision detect
						if(( DistX17*DistX17 + DistY17*DistY17) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol17 <= countCol17+1;
							if(countCol17 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>30) begin 
						Ball_Y18_Pos <= Ball_Y17_Pos; Ball_X18_Pos <= Ball_X17_Pos; //follow
						
						DistX18 <= Ball_X_Pos - Ball_X18_Pos; DistY18 <= Ball_Y_Pos - Ball_Y18_Pos;//collision detect
						if(( DistX18*DistX18 + DistY18*DistY18) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol18 <= countCol18+1;
							if(countCol18 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					if(active>32) begin 
						Ball_Y19_Pos <= Ball_Y18_Pos; Ball_X19_Pos <= Ball_X18_Pos; //follow
						//won <= 1;
						DistX19 <= Ball_X_Pos - Ball_X19_Pos; DistY19 <= Ball_Y_Pos - Ball_Y19_Pos;//collision detect
						if(( DistX19*DistX19 + DistY19*DistY19) <= 4*(Ball_Size * Ball_Size)) begin 
							countCol19 <= countCol19+1;
							if(countCol19 > 1) begin 
								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
							end	
						end
					 end
				else if (active>30)	begin   
					Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>28)	begin   
					Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>26)	begin   
					Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;
				 	Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>24)	begin   
					Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;
				 	Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>22)	begin   
					Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;
				 	Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;
				 	Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;
				 end
				else if (active>20)	begin   
					Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;
					Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;
				 	Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>18)	begin   
					Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;
					Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;
				 	Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;
				 	Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>16)	begin   
					Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;
					Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;
					Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;
					Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>14)	begin   
					Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;
					Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;
					Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;
				 	Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;
				 	Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>12)	begin   
					Ball_Y10_Pos <= Ball_Y_Pos; Ball_X10_Pos <= Ball_X_Pos;Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;
					Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;
					Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;
					Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;
					Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>10)	begin   
					Ball_Y9_Pos <= Ball_Y_Pos; Ball_X9_Pos <= Ball_X_Pos;Ball_Y10_Pos <= Ball_Y_Pos; Ball_X10_Pos <= Ball_X_Pos;
					Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;
					Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;
					Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;
				 	Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;
				 	Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>8)	begin   
					Ball_Y8_Pos <= Ball_Y_Pos; Ball_X8_Pos <= Ball_X_Pos;Ball_Y9_Pos <= Ball_Y_Pos; Ball_X9_Pos <= Ball_X_Pos;
					Ball_Y10_Pos <= Ball_Y_Pos; Ball_X10_Pos <= Ball_X_Pos;Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;
					Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;
					Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;
					Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;
				 	Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>6)	begin   
					Ball_Y7_Pos <= Ball_Y_Pos; Ball_X7_Pos <= Ball_X_Pos;Ball_Y8_Pos <= Ball_Y_Pos; Ball_X8_Pos <= Ball_X_Pos;
					Ball_Y9_Pos <= Ball_Y_Pos; Ball_X9_Pos <= Ball_X_Pos;Ball_Y10_Pos <= Ball_Y_Pos; Ball_X10_Pos <= Ball_X_Pos;
					Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;
					Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;
					Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;
				 	Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;
					Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>4)	begin   
					Ball_Y6_Pos <= Ball_Y_Pos; Ball_X6_Pos <= Ball_X_Pos; Ball_Y7_Pos <= Ball_Y_Pos; Ball_X7_Pos <= Ball_X_Pos;
					Ball_Y8_Pos <= Ball_Y_Pos; Ball_X8_Pos <= Ball_X_Pos;Ball_Y9_Pos <= Ball_Y_Pos; Ball_X9_Pos <= Ball_X_Pos;
					Ball_Y10_Pos <= Ball_Y_Pos; Ball_X10_Pos <= Ball_X_Pos;Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;
					Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;
					Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;
					Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;
				 	Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>2) begin  // after picking up first food active is 2
					Ball_Y5_Pos <= Ball_Y_Pos; Ball_X5_Pos <= Ball_X_Pos; //stay hidden
					Ball_Y6_Pos <= Ball_Y_Pos; Ball_X6_Pos <= Ball_X_Pos;Ball_Y7_Pos <= Ball_Y_Pos; Ball_X7_Pos <= Ball_X_Pos;
					Ball_Y8_Pos <= Ball_Y_Pos; Ball_X8_Pos <= Ball_X_Pos;Ball_Y9_Pos <= Ball_Y_Pos; Ball_X9_Pos <= Ball_X_Pos;
					Ball_Y10_Pos <= Ball_Y_Pos; Ball_X10_Pos <= Ball_X_Pos;Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;
					Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;
					Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;
					Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;
				 	Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end
				else if (active>0) begin 
					Ball_Y4_Pos <= Ball_Y_Pos; Ball_X4_Pos <= Ball_X_Pos; //stay hidden
					Ball_Y5_Pos <= Ball_Y_Pos; Ball_X5_Pos <= Ball_X_Pos;Ball_Y6_Pos <= Ball_Y_Pos; Ball_X6_Pos <= Ball_X_Pos; 
					Ball_Y7_Pos <= Ball_Y_Pos; Ball_X7_Pos <= Ball_X_Pos;Ball_Y8_Pos <= Ball_Y_Pos; Ball_X8_Pos <= Ball_X_Pos;
					Ball_Y9_Pos <= Ball_Y_Pos; Ball_X9_Pos <= Ball_X_Pos;Ball_Y10_Pos <= Ball_Y_Pos; Ball_X10_Pos <= Ball_X_Pos;
					Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;
					Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;
					Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;
				 	Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;
				 	Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos;
				 end 
				else begin //stay hidden every additional body part
					Ball_Y3_Pos <= Ball_Y_Pos; Ball_X3_Pos <= Ball_X_Pos; Ball_Y4_Pos <= Ball_Y_Pos; Ball_X4_Pos <= Ball_X_Pos; 
					Ball_Y5_Pos <= Ball_Y_Pos; Ball_X5_Pos <= Ball_X_Pos;Ball_Y6_Pos <= Ball_Y_Pos; Ball_X6_Pos <= Ball_X_Pos; 
					Ball_Y7_Pos <= Ball_Y_Pos; Ball_X7_Pos <= Ball_X_Pos;Ball_Y8_Pos <= Ball_Y_Pos; Ball_X8_Pos <= Ball_X_Pos;
					Ball_Y9_Pos <= Ball_Y_Pos; Ball_X9_Pos <= Ball_X_Pos;Ball_Y10_Pos <= Ball_Y_Pos; Ball_X10_Pos <= Ball_X_Pos;
					Ball_Y11_Pos <= Ball_Y_Pos; Ball_X11_Pos <= Ball_X_Pos;Ball_Y12_Pos <= Ball_Y_Pos; Ball_X12_Pos <= Ball_X_Pos;
					Ball_Y13_Pos <= Ball_Y_Pos; Ball_X13_Pos <= Ball_X_Pos;Ball_Y14_Pos <= Ball_Y_Pos; Ball_X14_Pos <= Ball_X_Pos;
					Ball_Y15_Pos <= Ball_Y_Pos; Ball_X15_Pos <= Ball_X_Pos;Ball_Y16_Pos <= Ball_Y_Pos; Ball_X16_Pos <= Ball_X_Pos;
				 	Ball_Y17_Pos <= Ball_Y_Pos; Ball_X17_Pos <= Ball_X_Pos;Ball_Y18_Pos <= Ball_Y_Pos; Ball_X18_Pos <= Ball_X_Pos;
				 	Ball_Y19_Pos <= Ball_Y_Pos; Ball_X19_Pos <= Ball_X_Pos; 
					  end

				if(count == 1 && start) begin //beginning code for case before pressing reset
					Food_X_Pos <= Food_X_Center; Food_Y_Pos <= Food_Y_Center;

					done<=0; active<=0; start<=1; won<=0; countCol3<=0; countCol4<=0; countCol5<=0; 
					countCol6<=0; countCol7<=0; countCol8<=0; countCol9<=0; countCol10<=0; countCol11<=0; 
					countCol12<=0; countCol13<=0; countCol14<=0; 
				 end
		 end
    end
       
    assign BallX = Ball_X_Pos;assign BallY = Ball_Y_Pos;assign FoodX = Food_X_Pos;assign FoodY = Food_Y_Pos;
    assign BallS = Ball_Size;assign BallX2 = Ball_X2_Pos;assign BallY2 = Ball_Y2_Pos;assign BallX3 = Ball_X3_Pos;
    assign BallY3 = Ball_Y3_Pos;assign BallX4 = Ball_X4_Pos;assign BallY4 = Ball_Y4_Pos; 
	assign BallX5 = Ball_X5_Pos;assign BallY5 = Ball_Y5_Pos;assign BallX6 = Ball_X6_Pos;assign BallY6 = Ball_Y6_Pos;
    assign BallX7 = Ball_X7_Pos;assign BallY7 = Ball_Y7_Pos;assign BallX8 = Ball_X8_Pos;assign BallY8 = Ball_Y8_Pos;
	assign BallX9 = Ball_X9_Pos;assign BallY9 = Ball_Y9_Pos; assign BallX10 = Ball_X10_Pos;assign BallY10 = Ball_Y10_Pos;
	assign BallX11 = Ball_X11_Pos;assign BallY11 = Ball_Y11_Pos;assign BallX12 = Ball_X12_Pos;assign BallY12 = Ball_Y12_Pos;
	assign BallX13 = Ball_X13_Pos;assign BallY13 = Ball_Y13_Pos;assign BallX14 = Ball_X14_Pos;assign BallY14 = Ball_Y14_Pos;
	assign BallX15 = Ball_X15_Pos;assign BallY15 = Ball_Y15_Pos;assign BallX16 = Ball_X16_Pos;assign BallY16 = Ball_Y16_Pos;
	assign BallX17 = Ball_X17_Pos;assign BallY17 = Ball_Y17_Pos;assign BallX18 = Ball_X18_Pos;assign BallY18 = Ball_Y18_Pos;
	assign BallX19 = Ball_X19_Pos;assign BallY19 = Ball_Y19_Pos;
endmodule




