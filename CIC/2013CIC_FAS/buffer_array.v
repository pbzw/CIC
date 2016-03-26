module buffer_array(
input clk,
input rst,
input enable,
input [31:0] fft_d0,
input [31:0] fft_d1,
input [31:0] fft_d2,
input [31:0] fft_d3,
input [31:0] fft_d4,
input [31:0] fft_d5,
input [31:0] fft_d6,
input [31:0] fft_d7,
input [31:0] fft_d8,
input [31:0] fft_d9,
input [31:0] fft_d10,
input [31:0] fft_d11,
input [31:0] fft_d12,
input [31:0] fft_d13,
input [31:0] fft_d14,
input [31:0] fft_d15,

output [31:0] sum_d0,
output [31:0] sum_d1,
output [31:0] sum_d2,
output [31:0] sum_d3,
output [31:0] sum_d4,
output [31:0] sum_d5,
output [31:0] sum_d6,
output [31:0] sum_d7,
output [31:0] sum_d8,
output [31:0] sum_d9,
output [31:0] sum_d10,
output [31:0] sum_d11,
output [31:0] sum_d12,
output [31:0] sum_d13,
output [31:0] sum_d14,
output [31:0] sum_d15,

output [3:0] tag_d0,
output [3:0] tag_d1,
output [3:0] tag_d2,
output [3:0] tag_d3,
output [3:0] tag_d4,
output [3:0] tag_d5,
output [3:0] tag_d6,
output [3:0] tag_d7,
output [3:0] tag_d8,
output [3:0] tag_d9,
output [3:0] tag_d10,
output [3:0] tag_d11,
output [3:0] tag_d12,
output [3:0] tag_d13,
output [3:0] tag_d14,
output [3:0] tag_d15,

output done
);

reg valid;

assign done=valid;

always@(posedge clk)
begin
	if(rst)
	valid<=0;
	else 
	valid<=enable;
end

sq_sum_buffer a0(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd0),
.data_in(fft_d0),

.tag(tag_d0),
.sum(sum_d0)
);

sq_sum_buffer a1(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd1),
.data_in(fft_d1),

.tag(tag_d1),
.sum(sum_d1)
);

sq_sum_buffer a2(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd2),
.data_in(fft_d2),

.tag(tag_d2),
.sum(sum_d2)
);

sq_sum_buffer a3(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd3),
.data_in(fft_d3),

.tag(tag_d3),
.sum(sum_d3)
);

sq_sum_buffer a4(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd4),
.data_in(fft_d4),

.tag(tag_d4),
.sum(sum_d4)
);

sq_sum_buffer a5(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd5),
.data_in(fft_d5),

.tag(tag_d5),
.sum(sum_d5)
);

sq_sum_buffer a6(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd6),
.data_in(fft_d6),

.tag(tag_d6),
.sum(sum_d6)
);

sq_sum_buffer a7(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd7),
.data_in(fft_d7),

.tag(tag_d7),
.sum(sum_d7)
);

sq_sum_buffer a8(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd8),
.data_in(fft_d8),

.tag(tag_d8),
.sum(sum_d8)
);

sq_sum_buffer a9(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd9),
.data_in(fft_d9),

.tag(tag_d9),
.sum(sum_d9)
);

sq_sum_buffer a10(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd10),
.data_in(fft_d10),

.tag(tag_d10),
.sum(sum_d10)
);

sq_sum_buffer a11(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd11),
.data_in(fft_d11),

.tag(tag_d11),
.sum(sum_d11)
);

sq_sum_buffer a12(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd12),
.data_in(fft_d12),

.tag(tag_d12),
.sum(sum_d12)
);

sq_sum_buffer a13(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd13),
.data_in(fft_d13),

.tag(tag_d13),
.sum(sum_d13)
);

sq_sum_buffer a14(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd14),
.data_in(fft_d14),

.tag(tag_d14),
.sum(sum_d14)
);

sq_sum_buffer a15(
.clk(clk),
.rst(rst),
.enable(enable),
.number(4'd15),
.data_in(fft_d15),

.tag(tag_d15),
.sum(sum_d15)
);
endmodule


module sq_sum_buffer(
input clk,
input rst,
input enable,
input [3:0]number,
input [31:0]data_in,

output [3:0]tag,
output [31:0]sum
);

wire [15:0] data_1,data_2;

sq_sum a(
.data_1(data_1),
.data_2(data_2),
.sum(sum)
);

buffer_32bit b(
.clk(clk),
.rst(rst),
.enable(enable),
.number(number),
.data_in(data_in),
.data_out_1(data_1),
.data_out_2(data_2),
.tag(tag)
);

endmodule

module sq_sum(
input [15:0]data_1,
input [15:0]data_2,
output [31:0]sum
);

wire [31:0]data_1_extend,data_2_extend;

assign data_1_extend=data_1[15]?{16'hffff,data_1}:{16'h0000,data_1};
assign data_2_extend=data_2[15]?{16'hffff,data_2}:{16'h0000,data_2};
assign sum=(data_1_extend*data_1_extend)+(data_2_extend*data_2_extend);

endmodule
module buffer_32bit(
input clk,
input rst,
input enable,
input [3:0]number,
input [31:0]data_in,
output [15:0]data_out_1,
output [15:0]data_out_2,
output reg [3:0] tag
);

reg [31:0]data;

assign data_out_1=data[31:16];
assign data_out_2=data[15:0];

always@(posedge clk)
begin
	if(rst)
	begin
	data<=32'd0;
	tag<=4'd0;
	end
	else if (enable)
	begin
	data<=data_in;
	tag<=number;
	end
end

endmodule

