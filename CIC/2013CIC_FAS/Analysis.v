module Analysis(
input clk,
input rst,
input  fft_valid,
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

output [3:0] freq,
output done
);

wire [31:0]sum_d0,sum_d1,sum_d2,sum_d3,sum_d4,sum_d5,sum_d6,sum_d7,sum_d8,sum_d9,sum_d10,sum_d11,sum_d12,sum_d13,sum_d14,sum_d15;
wire [3:0]tag_d0,tag_d1,tag_d2,tag_d3,tag_d4,tag_d5,tag_d6,tag_d7,tag_d8,tag_d9,tag_d10,tag_d11,tag_d12,tag_d13,tag_d14,tag_d15;

wire buffer_array_valid;

buffer_array a(
.clk(clk),
.rst(rst),
.enable(fft_valid),
.fft_d0(fft_d0),
.fft_d1(fft_d1),
.fft_d2(fft_d2),
.fft_d3(fft_d3),
.fft_d4(fft_d4),
.fft_d5(fft_d5),
.fft_d6(fft_d6),
.fft_d7(fft_d7),
.fft_d8(fft_d8),
.fft_d9(fft_d9),
.fft_d10(fft_d10),
.fft_d11(fft_d11),
.fft_d12(fft_d12),
.fft_d13(fft_d13),
.fft_d14(fft_d14),
.fft_d15(fft_d15),

.sum_d0(sum_d0),
.sum_d1(sum_d1),
.sum_d2(sum_d2),
.sum_d3(sum_d3),
.sum_d4(sum_d4),
.sum_d5(sum_d5),
.sum_d6(sum_d6),
.sum_d7(sum_d7),
.sum_d8(sum_d8),
.sum_d9(sum_d9),
.sum_d10(sum_d10),
.sum_d11(sum_d11),
.sum_d12(sum_d12),
.sum_d13(sum_d13),
.sum_d14(sum_d14),
.sum_d15(sum_d15),

.tag_d0(tag_d0),
.tag_d1(tag_d1),
.tag_d2(tag_d2),
.tag_d3(tag_d3),
.tag_d4(tag_d4),
.tag_d5(tag_d5),
.tag_d6(tag_d6),
.tag_d7(tag_d7),
.tag_d8(tag_d8),
.tag_d9(tag_d9),
.tag_d10(tag_d10),
.tag_d11(tag_d11),
.tag_d12(tag_d12),
.tag_d13(tag_d13),
.tag_d14(tag_d14),
.tag_d15(tag_d15),
.done(buffer_array_valid)
);

find_max b(
.clk(clk),
.rst(rst),
.enable(buffer_array_valid),
.data_d0(sum_d0),
.data_d1(sum_d1),
.data_d2(sum_d2),
.data_d3(sum_d3),
.data_d4(sum_d4),
.data_d5(sum_d5),
.data_d6(sum_d6),
.data_d7(sum_d7),
.data_d8(sum_d8),
.data_d9(sum_d9),
.data_d10(sum_d10),
.data_d11(sum_d11),
.data_d12(sum_d12),
.data_d13(sum_d13),
.data_d14(sum_d14),
.data_d15(sum_d15),

.tag_d0(tag_d0),
.tag_d1(tag_d1),
.tag_d2(tag_d2),
.tag_d3(tag_d3),
.tag_d4(tag_d4),
.tag_d5(tag_d5),
.tag_d6(tag_d6),
.tag_d7(tag_d7),
.tag_d8(tag_d8),
.tag_d9(tag_d9),
.tag_d10(tag_d10),
.tag_d11(tag_d11),
.tag_d12(tag_d12),
.tag_d13(tag_d13),
.tag_d14(tag_d14),
.tag_d15(tag_d15),
.max(freq),
.done(done)
);

endmodule

module find_max(
input clk,
input rst,
input enable,
input [31:0] data_d0,
input [31:0] data_d1,
input [31:0] data_d2,
input [31:0] data_d3,
input [31:0] data_d4,
input [31:0] data_d5,
input [31:0] data_d6,
input [31:0] data_d7,
input [31:0] data_d8,
input [31:0] data_d9,
input [31:0] data_d10,
input [31:0] data_d11,
input [31:0] data_d12,
input [31:0] data_d13,
input [31:0] data_d14,
input [31:0] data_d15,

input [3:0] tag_d0,
input [3:0] tag_d1,
input [3:0] tag_d2,
input [3:0] tag_d3,
input [3:0] tag_d4,
input [3:0] tag_d5,
input [3:0] tag_d6,
input [3:0] tag_d7,
input [3:0] tag_d8,
input [3:0] tag_d9,
input [3:0] tag_d10,
input [3:0] tag_d11,
input [3:0] tag_d12,
input [3:0] tag_d13,
input [3:0] tag_d14,
input [3:0] tag_d15,

output [3:0]max,
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


wire [31:0] biger_data_level_1_0,biger_data_level_1_1,biger_data_level_1_2,
				biger_data_level_1_3,biger_data_level_1_4,biger_data_level_1_5,
				biger_data_level_1_6,biger_data_level_1_7;
wire [3:0] biger_tag_level_1_0,biger_tag_level_1_1,biger_tag_level_1_2,
				biger_tag_level_1_3,biger_tag_level_1_4,biger_tag_level_1_5,
				biger_tag_level_1_6,biger_tag_level_1_7;
				
wire [31:0] biger_data_level_2_0,biger_data_level_2_1,biger_data_level_2_2,
				biger_data_level_2_3;
wire [3:0] biger_tag_level_2_0,biger_tag_level_2_1,biger_tag_level_2_2,
				biger_tag_level_2_3;

wire [31:0] biger_data_level_3_0,biger_data_level_3_1;
wire [3:0] biger_tag_level_3_0,biger_tag_level_3_1;

wire [31:0] biger_data_level_4_0;
wire [3:0] biger_tag_level_4_0;

assign max=biger_tag_level_4_0;

find_biger a0(
.in_data_0(data_d0),
.in_data_1(data_d1),
.in_data_0_tag(tag_d0),
.in_data_1_tag(tag_d1),

.biger_data(biger_data_level_1_0),
.biger_tag(biger_tag_level_1_0)
);

find_biger a1(
.in_data_0(data_d2),
.in_data_1(data_d3),
.in_data_0_tag(tag_d2),
.in_data_1_tag(tag_d3),

.biger_data(biger_data_level_1_1),
.biger_tag(biger_tag_level_1_1)
);

find_biger a2(
.in_data_0(data_d4),
.in_data_1(data_d5),
.in_data_0_tag(tag_d4),
.in_data_1_tag(tag_d5),

.biger_data(biger_data_level_1_2),
.biger_tag(biger_tag_level_1_2)
);

find_biger a3(
.in_data_0(data_d6),
.in_data_1(data_d7),
.in_data_0_tag(tag_d6),
.in_data_1_tag(tag_d7),

.biger_data(biger_data_level_1_3),
.biger_tag(biger_tag_level_1_3)
);

find_biger a4(
.in_data_0(data_d8),
.in_data_1(data_d9),
.in_data_0_tag(tag_d8),
.in_data_1_tag(tag_d9),

.biger_data(biger_data_level_1_4),
.biger_tag(biger_tag_level_1_4)
);

find_biger a5(
.in_data_0(data_d10),
.in_data_1(data_d11),
.in_data_0_tag(tag_d10),
.in_data_1_tag(tag_d11),

.biger_data(biger_data_level_1_5),
.biger_tag(biger_tag_level_1_5)
);

find_biger a6(
.in_data_0(data_d12),
.in_data_1(data_d13),
.in_data_0_tag(tag_d12),
.in_data_1_tag(tag_d13),

.biger_data(biger_data_level_1_6),
.biger_tag(biger_tag_level_1_6)
);

find_biger a7(
.in_data_0(data_d14),
.in_data_1(data_d15),
.in_data_0_tag(tag_d14),
.in_data_1_tag(tag_d15),

.biger_data(biger_data_level_1_7),
.biger_tag(biger_tag_level_1_7)
);

find_biger b0(
.in_data_0(biger_data_level_1_0),
.in_data_1(biger_data_level_1_1),
.in_data_0_tag(biger_tag_level_1_0),
.in_data_1_tag(biger_tag_level_1_1),

.biger_data(biger_data_level_2_0),
.biger_tag(biger_tag_level_2_0)
);

find_biger b1(
.in_data_0(biger_data_level_1_2),
.in_data_1(biger_data_level_1_3),
.in_data_0_tag(biger_tag_level_1_2),
.in_data_1_tag(biger_tag_level_1_3),

.biger_data(biger_data_level_2_1),
.biger_tag(biger_tag_level_2_1)
);

find_biger b2(
.in_data_0(biger_data_level_1_4),
.in_data_1(biger_data_level_1_5),
.in_data_0_tag(biger_tag_level_1_4),
.in_data_1_tag(biger_tag_level_1_5),

.biger_data(biger_data_level_2_2),
.biger_tag(biger_tag_level_2_2)
);

find_biger b3(
.in_data_0(biger_data_level_1_6),
.in_data_1(biger_data_level_1_7),
.in_data_0_tag(biger_tag_level_1_6),
.in_data_1_tag(biger_tag_level_1_7),

.biger_data(biger_data_level_2_3),
.biger_tag(biger_tag_level_2_3)
);

find_biger c0(
.in_data_0(biger_data_level_2_0),
.in_data_1(biger_data_level_2_1),
.in_data_0_tag(biger_tag_level_2_0),
.in_data_1_tag(biger_tag_level_2_1),

.biger_data(biger_data_level_3_0),
.biger_tag(biger_tag_level_3_0)
);

find_biger c1(
.in_data_0(biger_data_level_2_2),
.in_data_1(biger_data_level_2_3),
.in_data_0_tag(biger_tag_level_2_2),
.in_data_1_tag(biger_tag_level_2_3),

.biger_data(biger_data_level_3_1),
.biger_tag(biger_tag_level_3_1)
);

find_biger d0(
.in_data_0(biger_data_level_3_0),
.in_data_1(biger_data_level_3_1),
.in_data_0_tag(biger_tag_level_3_0),
.in_data_1_tag(biger_tag_level_3_1),

.biger_data(biger_data_level_4_0),
.biger_tag(biger_tag_level_4_0)
);
endmodule

module find_biger(
input[31:0]in_data_0,
input[31:0]in_data_1,
input[3:0]in_data_0_tag,
input[3:0]in_data_1_tag,

output[31:0]biger_data,
output[3:0]biger_tag
);

assign biger_data=(in_data_0>=in_data_1)?in_data_0:in_data_1;
assign biger_tag=(in_data_0>=in_data_1)?in_data_0_tag:in_data_1_tag;

endmodule
