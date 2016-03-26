module Nnad_flash_reader_state_machine(
  input clk,
  input rst,
  input wait_,
  
  output F_CLE_A,
  output F_ALE_A,
  output F_REN_A,
  output F_WEN_A,
  output com_en,
  output address_en_0,
  output address_en_1,
  output address_en_2,
  output data_en,
  
  output [23:0]address_count,
  input  F_RB_A
 );
 reg [4:0]state,next;
 wire count_en;
 parameter idle=5'd0;
 parameter cmd_stage_1=5'b00001;
 parameter cmd_stage_2=5'b00010;
 parameter cmd_stage_3=5'b00011;
 
 parameter test =5'b00100;
 
 parameter ads_stage_1=5'b01100;
 parameter ads_stage_2=5'b01101;
 parameter ads_stage_3=5'b01110;
 parameter ads_stage_4=5'b01111;
 parameter ads_stage_5=5'b01000;
 parameter ads_stage_6=5'b01001;
 parameter ads_stage_7=5'b01010;
 parameter ads_stage_8=5'b01011;
 
 parameter dr_stage_1=5'b10000;
 parameter dr_stage_2=5'b10001;
 parameter dr_stage_3=5'b10010;
 parameter dr_stage_4=5'b10011;
 parameter fininsh=5'b11000;
 
 assign F_CLE_A=(state==cmd_stage_1)|(state==cmd_stage_2)|(state==cmd_stage_3);
 assign F_ALE_A=(state[4:3]==2'b01);
 assign F_WEN_A=!((state==cmd_stage_2)|(state==ads_stage_3)|(state==ads_stage_5)|(state==ads_stage_7)|(state==idle)|(state==cmd_stage_1));
 assign F_REN_A=!(state==dr_stage_3);
 
 assign count_en=!F_REN_A;
 assign com_en=(state==cmd_stage_2)|(state==cmd_stage_3);
 
 assign address_en_0=(state==ads_stage_3)|(state==ads_stage_4);
 assign address_en_1=(state==ads_stage_5)|(state==ads_stage_6);
 assign address_en_2=(state==ads_stage_7)|(state==ads_stage_8);
 assign data_en=(state==dr_stage_3);
 
 
 count_24_bit cnt (
 .clk(clk),
 .rst(rst),
 .count(address_count),
 .en(count_en)
 );
 always@(posedge clk,posedge rst)
 begin
	if(rst)
	state<=idle;
	else
	state<=next;
 end
 
 
 always@(*)
 begin
	case(state)
   idle	 	  :begin
					if(address_count>=24'h3ffff)
					next= fininsh;
					else
					next=cmd_stage_1;
					end
	cmd_stage_1:next=cmd_stage_2;
	cmd_stage_2:next=cmd_stage_3;
	cmd_stage_3:next=ads_stage_1;
	ads_stage_1:next=ads_stage_2;
	ads_stage_2:next=ads_stage_3;
	ads_stage_3:next=ads_stage_4;
	ads_stage_4:next=ads_stage_5;
	ads_stage_5:next=ads_stage_6;
	ads_stage_6:next=ads_stage_7;
	ads_stage_7:next= ads_stage_8;
	ads_stage_8:begin
					if(F_RB_A)
					next= dr_stage_1;
					else
					next= ads_stage_8;
					end
					
	dr_stage_1:next= dr_stage_2;
	dr_stage_2:next= dr_stage_3;
	dr_stage_3:next= dr_stage_4;
	dr_stage_4:begin
					if(wait_)
					next=dr_stage_4;
					else if(address_count[8:0]!=9'd0)
					next= dr_stage_1;
					else
					next= idle;
				  end
	fininsh :next=fininsh;
	default
	next=idle;
	endcase
	
 end
 
 
 endmodule
 
 module count_24_bit(
  input clk,
  input rst,
  input en,
  output reg [23:0]count
 );
  always@(posedge clk,posedge rst)
 begin
	if(rst)
	count<=24'd0;
	else if(en)
	count<=count+24'd1;
 end
 endmodule
 