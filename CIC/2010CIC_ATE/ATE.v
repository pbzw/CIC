module ATE(clk,reset,pix_data,type,bin,threshold);
input clk;
input reset;
input [7:0] pix_data;
input type;
output  bin;
output [7:0] threshold;

wire [7:0]line_buffer_out_data,front_threshold;
wire [6:0]line_counter_count,encode;
wire [12:0]block_counter_count,acc_count;
wire ok;







front front(
.clk(clk),
.rst(reset),
.data(pix_data),
.out_data(line_buffer_out_data),
.threshold(front_threshold),
.pix64(ok)
);


 back back(
.clk(clk),
.rst(reset),
.en(ok),
.type(type),
.data(line_buffer_out_data),
.threshold(front_threshold),
.threshold_out(threshold),
.bin(bin)
);



endmodule

module back(
input clk,
input rst,
input en,
input type,
input [7:0]data,
input [7:0]threshold,
output [7:0]threshold_out,
output bin
);
wire line_clr;
wire [12:0]block_counter_count;
wire [6:0]encode,line_counter_count;
reg [7:0]buff_data,buff_data_1,buff_thresholdl;

assign ed=(line_counter_count==7'b1)|(line_counter_count==encode);
assign threshold_out=ed?8'd00:buff_thresholdl;
assign encode=type?7'd66:7'd6;
assign line_clr=(encode==line_counter_count)&en;
assign bin=(buff_data_1>=threshold_out)&(!ed);

up_counter #(.WIDTH (7)) line_counter(
.clk(clk),
.rst(rst),
.clr(line_clr),
.en(en),
.count(line_counter_count)
);

up_counter #(.WIDTH (13)) block_counter(
.clk(clk),
.rst(rst),
.clr(1'b0),
.en(en),
.count(block_counter_count)
);

always@(posedge clk)
begin
	buff_data <=data;
	buff_data_1<=buff_data;
	if(en)
	buff_thresholdl<=threshold;
end

endmodule

module front(
input clk,
input rst,
input [7:0]data,
output [7:0]out_data,
output [7:0]threshold,
output pix64
);
wire [7:0]max_counter_out_data,min_counter_out_data;
wire [8:0]add={1'b0,min_counter_out_data}+{1'b0,max_counter_out_data};

wire [6:0]data_counter_count;
assign pix64=(data_counter_count==7'd64);
assign threshold=(add[8:1]+{7'b0,add[0]});
line_buffer line_buffer(
.clk(clk),
.rst(rst),
.en(1'b1),
.data_in(data),
.data_out(out_data)
);
up_counter #(.WIDTH (7)) data_counter(
.clk(clk),
.rst(rst),
.clr(pix64),
.en(1'b1),
.count(data_counter_count)
);


max_counter #(.WIDTH (8)) max_counter(
.clk(clk),
.rst(rst),
.clr(pix64),
.in_data(data),
.out_data(max_counter_out_data)
);

min_counter #(.WIDTH (8)) min_counter(
.clk(clk),
.rst(rst),
.clr(pix64),
.in_data(data),
.out_data(min_counter_out_data)
);

endmodule

module line_buffer(
input clk,
input rst,
input en,
input [7:0]data_in,
output [7:0]data_out
);
reg [7:0]mem[0:63];
wire [5:0]write_counter_count,read_counter_count;
assign data_out=mem[(read_counter_count+6'b1)];
up_counter #(.WIDTH (6)) write_counter(
.clk(clk),
.rst(rst),
.clr(1'b0),
.en(en),
.count(write_counter_count)
);

up_counter #(.WIDTH (6)) read_counter(
.clk(clk),
.rst(rst),
.clr(1'b0),
.en(en),
.count(read_counter_count)
);

always @(posedge clk)
begin
mem[write_counter_count]<=data_in;
end

endmodule

module max_counter #(parameter WIDTH = 32)(
input clk,
input rst,
input en,
input clr,
input [7:0]in_data,
output reg[WIDTH-1:0] out_data
);
parameter zero={(WIDTH){1'b0}};


always@(posedge clk)
begin
	if(rst)
	out_data<=zero;
	else if(clr)
	out_data<=(in_data>zero)?in_data:zero;
	else if(out_data<in_data)
	out_data<=in_data;
end

endmodule

module min_counter #(parameter WIDTH = 32)(
input clk,
input rst,
input clr,
input [7:0]in_data,
output reg[WIDTH-1:0] out_data
);
parameter zero={(WIDTH){1'b1}};


always@(posedge clk)
begin
	if(rst)
	out_data<=zero;
	else if(clr)
	out_data<=(in_data<zero)?in_data:zero;
	else if(out_data>in_data)
	out_data<=in_data;
end

endmodule

module add_counter #(parameter WIDTH = 32)(
input clk,
input rst,
input en,
input [7:0]data_in_1,
input [7:0]data_in_2,
output reg[WIDTH-1:0] count
);
parameter zero={(WIDTH){1'b0}};


always@(posedge clk)
begin
	if(rst)
	count<=zero;
	else if(en)
	count<=((data_in_2+data_in_1)>>1);
end

endmodule
