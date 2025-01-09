//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab62 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 
);

logic Reset_h, vssig, blank, sync, VGA_Clk, delay1;

assign delay1 = 50000;

//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig, ballxsig2, ballysig2, ballxsig3, ballysig3, 
				ballxsig4, ballysig4, ballxsig5, ballysig5, ballxsig6, ballysig6, ballxsig7, ballysig7, 
				ballxsig8, ballysig8, ballxsig9, ballysig9, ballxsig10, ballysig10, ballxsig11, ballysig11,
				ballxsig12, ballysig12, ballxsig13, ballysig13, ballxsig14, ballysig14, ballxsig15, ballysig15,
				ballxsig16, ballysig16, ballxsig17, ballysig17, ballxsig18, ballysig18, ballxsig19, ballysig19,
				foodxsig, foodysig; 
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;
	
//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	

	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	
	lab62_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
		
	 );


//instantiate a vga_controller, ball, and color_mapper here with the ports.

vga_controller Vcontroller(.Clk(MAX10_CLK1_50), .Reset(Reset_h), .hs(VGA_HS), .vs(VGA_VS),
								   .pixel_clk(VGA_Clk), .blank(blank),   .sync(sync), 
									.DrawX(drawxsig), .DrawY(drawysig)
);



color_mapper cMap(.BallX(ballxsig), .BallY(ballysig), .DrawX(drawxsig), .DrawY(drawysig), .Ball_size(ballsizesig), .blank(blank),
						.BallX2(ballxsig2), .BallY2(ballysig2), .FoodX(foodxsig), .FoodY(foodysig), 
						.BallX3(ballxsig3), .BallY3(ballysig3), .BallX4(ballxsig4), .BallY4(ballysig4),
						.BallX5(ballxsig5), .BallY5(ballysig5), .BallX6(ballxsig6), .BallY6(ballysig6),
						.BallX7(ballxsig7), .BallY7(ballysig7), .BallX8(ballxsig8), .BallY8(ballysig8),
						.BallX9(ballxsig9), .BallY9(ballysig9), .BallX10(ballxsig10), .BallY10(ballysig10),
						.BallX11(ballxsig11), .BallY11(ballysig11), .BallX12(ballxsig12), .BallY12(ballysig12),
						.BallX13(ballxsig13), .BallY13(ballysig13), .BallX14(ballxsig14), .BallY14(ballysig14),
						.BallX15(ballxsig15), .BallY15(ballysig15), .BallX16(ballxsig16), .BallY16(ballysig16),
						.BallX17(ballxsig17), .BallY17(ballysig17), .BallX18(ballxsig18), .BallY18(ballysig18),  
						.BallX19(ballxsig19), .BallY19(ballysig19), .Red(Red), .Green(Green), .Blue(Blue)
);


snake Snake(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode),
            .BallX(ballxsig), .BallY(ballysig), .BallS(ballsizesig), .BallX2(ballxsig2), .BallY2(ballysig2),
			.FoodX(foodxsig), .FoodY(foodysig),
			.BallX3(ballxsig3), .BallY3(ballysig3), .BallX4(ballxsig4), .BallY4(ballysig4),
			.BallX5(ballxsig5), .BallY5(ballysig5), .BallX6(ballxsig6), .BallY6(ballysig6),
			.BallX7(ballxsig7), .BallY7(ballysig7), .BallX8(ballxsig8), .BallY8(ballysig8),
			.BallX9(ballxsig9), .BallY9(ballysig9), .BallX10(ballxsig10), .BallY10(ballysig10),
			.BallX11(ballxsig11), .BallY11(ballysig11), .BallX12(ballxsig12), .BallY12(ballysig12),
			.BallX13(ballxsig13), .BallY13(ballysig13), .BallX14(ballxsig14), .BallY14(ballysig14),
			.BallX15(ballxsig15), .BallY15(ballysig15), .BallX16(ballxsig16), .BallY16(ballysig16),
			.BallX17(ballxsig17), .BallY17(ballysig17), .BallX18(ballxsig18), .BallY18(ballysig18),  
			.BallX19(ballxsig19), .BallY19(ballysig19),  
			   		   
);

endmodule







//game_interface ( .Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode),
//               .BallX(ballxsig), .BallY(ballysig), .BallS(ballsizesig);


// body Body1(.Reset(Reset_h), .frame_clk(VGA_VS), .delay(0), .keycode(keycode), .startX(bxStart1), .startY(byStart1),
// 			.followX(ballxsig), .followY(ballysig),
//             .bodyX(ballxsig2), .bodyY(ballysig2),
// );


// food Food( input Reset, frame_clk,
// 					input [9:0] headX, headY,
//                output [9:0]  fruitX, fruitY);



// if(active>) begin 
// 						Ball_Y#_Pos <= Ball_Y$_Pos; Ball_X#_Pos <= Ball_X$_Pos; //follow
						
// 						DistX# <= Ball_X_Pos - Ball_X#_Pos; DistY# <= Ball_Y_Pos - Ball_Y#_Pos;//collision detect
// 						if(( DistX#*DistX# + DistY#*DistY#) <= 4*(Ball_Size * Ball_Size)) begin 
// 							countCol# <= countCol#+1;
// 							if(countCol# > 1) begin 
// 								done <= 1; Ball_Y_Motion <= 0; Ball_X_Motion <= 0; end	
// 							end	
// 						end