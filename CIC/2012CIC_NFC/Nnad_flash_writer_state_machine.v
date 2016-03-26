module Nnad_flash_writer_state_machine(
  input clk,
  input rst,
  input en,
  
  output F_CLE_B,
  output F_ALE_B,
  output F_REN_B,
  output F_WEN_B,
  
  output data_get,
  
  output com_en,
  output address_en_0,
  output address_en_1,
  output address_en_2,
  output data_en,
  output reg[7:0]cmd,
  
  output done,
  
  output [23:0]address_count,
  input  F_RB_B
 );
 
 reg [6:0]state,next;
 wire count_en;
 
 parameter idle=7'b1111111;
 
 parameter cmd_0x01_stage_1=7'b00_00_001;
 parameter cmd_0x01_stage_2=7'b00_00_010;
 parameter cmd_0x01_stage_3=7'b00_00_011;
 
 parameter cmd_0x80_stage_1=7'b00_01_001;
 parameter cmd_0x80_stage_2=7'b00_01_010;
 parameter cmd_0x80_stage_3=7'b00_01_011;
 
 parameter cmd_0x10_stage_1=7'b00_10_001;
 parameter cmd_0x10_stage_2=7'b00_10_010;
 parameter cmd_0x10_stage_3=7'b00_10_011;
 
 parameter ads_stage_1=7'b01_00000;
 parameter ads_stage_2=7'b01_00001;
 parameter ads_stage_3=7'b01_11_010;
 parameter ads_stage_4=7'b01_00011;
 parameter ads_stage_5=7'b01_11_100;
 parameter ads_stage_6=7'b01_00101;
 parameter ads_stage_7=7'b01_11_110;
 parameter ads_stage_8=7'b01_00110;
 
 parameter di_stage_1=7'b10_00000;
 parameter di_stage_2=7'b10_00001;
 parameter di_stage_3=7'b10_00010;
 parameter di_stage_4=7'b10_00011;
 parameter di_stage_5=7'b10_00100;
 
 parameter wait_F_RB=7'b1100001;
 parameter fininsh=7'b11_00000;
 
assign F_CLE_B=(state[6:5]==2'b00);
assign F_ALE_B=(state[6:5]==2'b01);
assign F_WEN_B=!(({state[6:5],state[1:0]}==4'b0010)|(state[6:3]==4'b0111)|(state==di_stage_3)|(state==idle)|({state[6:5],state[2:0]}==5'b00001));
assign F_REN_B=1;
 
assign count_en=(state==di_stage_1)&en;
assign done =(state==fininsh);

assign com_en=({state[6:5],state[2:1]}==5'b0001);
assign address_en_0=(state==ads_stage_3)|(state==ads_stage_4);
assign address_en_1=(state==ads_stage_5)|(state==ads_stage_6);
assign address_en_2=(state==ads_stage_7)|(state==ads_stage_8);

assign data_en= (state[6:5]==2'b10);

assign data_get=(state==di_stage_2); 

 count_24_bit cnt (
 .clk(clk),
 .rst(rst),
 .count(address_count),
 .en(count_en)
 );
 
 always@(*)
 begin
	case (state[4:3])
	2'b00:cmd=8'h01;
	2'b01:cmd=8'h80;
	2'b10:cmd=8'h10;
	default
	cmd=8'h00;
	endcase
 end
 
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
					if(address_count>24'h3ffff)
					next=fininsh;
					else if(address_count[8])
					next=cmd_0x01_stage_1;
					else
					next=cmd_0x80_stage_1;
					end
	cmd_0x01_stage_1:next=cmd_0x01_stage_2;
	cmd_0x01_stage_2:next=cmd_0x01_stage_3;
	cmd_0x01_stage_3:next=cmd_0x80_stage_1;
	
	cmd_0x80_stage_1:next=cmd_0x80_stage_2;
	cmd_0x80_stage_2:next=cmd_0x80_stage_3;
	cmd_0x80_stage_3:next=ads_stage_1;
	
	cmd_0x10_stage_1:next=cmd_0x10_stage_2;
	cmd_0x10_stage_2:next=cmd_0x10_stage_3;
	cmd_0x10_stage_3:next=wait_F_RB;
	
	wait_F_RB:begin
				 if(F_RB_B)
				 next=idle;
				 else
				 next=wait_F_RB;
				 end
	
	ads_stage_1:next=ads_stage_2;
	ads_stage_2:next=ads_stage_3;
	ads_stage_3:next=ads_stage_4;
	ads_stage_4:next=ads_stage_5;
	ads_stage_5:next=ads_stage_6;
	ads_stage_6:next=ads_stage_7;
	ads_stage_7:next=ads_stage_8;
	ads_stage_8:next=di_stage_1;

	di_stage_1:begin
				  if(en)
					next= di_stage_2;
				  else
					next= di_stage_1;
				  end
	di_stage_2:next= di_stage_3;
	di_stage_3:next= di_stage_4;
	di_stage_4:next= di_stage_5;
	di_stage_5:begin
					if(address_count[8:0]!=9'd0)
					next=di_stage_1;
					else 
					next= cmd_0x10_stage_1;
				  end
	fininsh :next=fininsh;
	endcase
	
 end
 
 
 endmodule