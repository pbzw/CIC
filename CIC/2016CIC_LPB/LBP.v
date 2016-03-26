
`timescale 1ns/10ps
module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, lbp_valid, lbp_data, finish);
input   	clk;
input   	reset;
output  [13:0] 	gray_addr;
output         	gray_req;
input   	gray_ready;
input   [7:0] 	gray_data;
output  [13:0] 	lbp_addr;
output reg lbp_valid;
output  [7:0] 	lbp_data ;
output  	finish;
//====================================================================

wire rst=reset;
reg [3:0]state;
reg[3:0]nstate;
parameter idle=4'b0000;
parameter done=4'b0001;
parameter intial= 4'b0010;
parameter busy  =4'b0011;
parameter get_data=4'b0111;
parameter wait_1  =4'b0100;

wire [7:0]gp;
wire ed;
reg  [7:0]mask_data_out_1,mask_data_out_2,mask_data_out_3,mask_data_out_4,mask_data_out_5,mask_data_out_6,mask_data_out_7,mask_data_out_8,mask_data_out_9;
wire mask_data_valid;
wire [13:0]mem_addr_count,write_addr_count;
wire [7:0]line_buffer_1_out,line_buffer_2_out,line_buffer_3_out;
wire line_buffer_1_valid,line_buffer_2_valid,line_buffer_3_valid;

assign gray_req=(state==wait_1)|(state==get_data);
assign gray_addr=mem_addr_count;
assign lbp_addr=write_addr_count;

assign lbp_data=ed?8'b0:gp;
assign finish=(state==done);


assign ed=(write_addr_count[13:7]==7'b0)|(write_addr_count[6:0]==7'b0)|(write_addr_count[13:7]==7'h7f)|(write_addr_count[6:0]==7'h7f);
/*state_machine*/





always@(posedge clk,posedge rst)
begin
	if(rst)
	state<=idle;
	else
	state<=nstate;
end
always@(posedge clk,posedge rst)
begin 
	if(rst)
	lbp_valid<=1'b0;
	else if(mem_addr_count>14'd128)
	lbp_valid<=1'b1;
end
always@(*)
begin
	case(state)
	idle:begin
			nstate=intial;
			end
	intial:begin
		if(gray_ready)
		 nstate=wait_1;
		 else
		 nstate=intial;
		 end
	wait_1:begin
			nstate=get_data;
			end
	get_data:begin
			if(write_addr_count==14'h3fff)
			nstate=done;
			else
			nstate=get_data;
			end
	done:nstate=done;
	default:	nstate=idle;
	endcase
end
/**/
up_counter #(.WIDTH(14))mem_addr_counter(
.clk(clk),
.rst(rst),
.en((state==get_data)),
.clr(1'b0),
.count(mem_addr_count)
);

up_counter #(.WIDTH(14))write_addr_counter(
.clk(clk),
.rst(rst),
.en(lbp_valid),
.clr(1'b0),
.count(write_addr_count)
);

 line_buffer line_buffer_1(
.clk(clk),
.rst(rst),
.en((state==get_data)|(state==wait_1)),
.data_in(gray_data),
.data_out(line_buffer_1_out),
.valid(line_buffer_1_valid)
);

 line_buffer line_buffer_2(
.clk(clk),
.rst(rst),
.en(line_buffer_1_valid),
.data_in(line_buffer_1_out),
.data_out(line_buffer_2_out),
.valid(line_buffer_2_valid)
);

always@(posedge clk)
begin
		if((state==get_data)|(state==wait_1))
			begin
			mask_data_out_1<=gray_data;
			mask_data_out_2<=mask_data_out_1;
			mask_data_out_3<=mask_data_out_2;
			end
		if(line_buffer_1_valid)
			begin
			mask_data_out_4<=line_buffer_1_out;
			mask_data_out_5<=mask_data_out_4;
			mask_data_out_6<=mask_data_out_5;
			end
		if(line_buffer_2_valid)
			begin
			mask_data_out_7<=line_buffer_2_out;
			mask_data_out_8<=mask_data_out_7;
			mask_data_out_9<=mask_data_out_8;
			end
end
assign gp[7]=mask_data_out_1>=mask_data_out_5;
assign gp[6]=mask_data_out_2>=mask_data_out_5;
assign gp[5]=mask_data_out_3>=mask_data_out_5;
assign gp[4]=mask_data_out_4>=mask_data_out_5;
assign gp[3]=mask_data_out_6>=mask_data_out_5;
assign gp[2]=mask_data_out_7>=mask_data_out_5;
assign gp[1]=mask_data_out_8>=mask_data_out_5;
assign gp[0]=mask_data_out_9>=mask_data_out_5;

//====================================================================
endmodule
