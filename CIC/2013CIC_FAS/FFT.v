module FFT(
input [15:0]fir_d,
input fir_valid,
input clk,
input rst,
output fft_valid,
output [31:0] fft_d0,
output [31:0] fft_d1,
output [31:0] fft_d2,
output [31:0] fft_d3,
output [31:0] fft_d4,
output [31:0] fft_d5,
output [31:0] fft_d6,
output [31:0] fft_d7,
output [31:0] fft_d8,
output [31:0] fft_d9,
output [31:0] fft_d10,
output [31:0] fft_d11,
output [31:0] fft_d12,
output [31:0] fft_d13,
output [31:0] fft_d14,
output [31:0] fft_d15
);

wire [15:0]Parallel_to_16_point_0,Parallel_to_16_point_1,Parallel_to_16_point_2,Parallel_to_16_point_3;
wire [15:0]Parallel_to_16_point_4,Parallel_to_16_point_5,Parallel_to_16_point_6,Parallel_to_16_point_7;
wire [15:0]Parallel_to_16_point_8,Parallel_to_16_point_9,Parallel_to_16_point_10,Parallel_to_16_point_11;
wire [15:0]Parallel_to_16_point_12,Parallel_to_16_point_13,Parallel_to_16_point_14,Parallel_to_16_point_15;

wire [31:0]point_16_to_8_point_real_0,point_16_to_8_point_real_1,point_16_to_8_point_real_2,point_16_to_8_point_real_3;
wire [31:0]point_16_to_8_point_real_4,point_16_to_8_point_real_5,point_16_to_8_point_real_6,point_16_to_8_point_real_7;
wire [31:0]point_16_to_8_point_real_8,point_16_to_8_point_real_9,point_16_to_8_point_real_10,point_16_to_8_point_real_11;
wire [31:0]point_16_to_8_point_real_12,point_16_to_8_point_real_13,point_16_to_8_point_real_14,point_16_to_8_point_real_15;

wire [31:0]point_16_to_8_point_imag_0,point_16_to_8_point_imag_1,point_16_to_8_point_imag_2,point_16_to_8_point_imag_3;
wire [31:0]point_16_to_8_point_imag_4,point_16_to_8_point_imag_5,point_16_to_8_point_imag_6,point_16_to_8_point_imag_7;
wire [31:0]point_16_to_8_point_imag_8,point_16_to_8_point_imag_9,point_16_to_8_point_imag_10,point_16_to_8_point_imag_11;
wire [31:0]point_16_to_8_point_imag_12,point_16_to_8_point_imag_13,point_16_to_8_point_imag_14,point_16_to_8_point_imag_15;

wire [31:0]point_8_to_4_point_real_0,point_8_to_4_point_real_1,point_8_to_4_point_real_2,point_8_to_4_point_real_3;
wire [31:0]point_8_to_4_point_real_4,point_8_to_4_point_real_5,point_8_to_4_point_real_6,point_8_to_4_point_real_7;
wire [31:0]point_8_to_4_point_real_8,point_8_to_4_point_real_9,point_8_to_4_point_real_10,point_8_to_4_point_real_11;
wire [31:0]point_8_to_4_point_real_12,point_8_to_4_point_real_13,point_8_to_4_point_real_14,point_8_to_4_point_real_15;

wire [31:0]point_8_to_4_point_imag_0,point_8_to_4_point_imag_1,point_8_to_4_point_imag_2,point_8_to_4_point_imag_3;
wire [31:0]point_8_to_4_point_imag_4,point_8_to_4_point_imag_5,point_8_to_4_point_imag_6,point_8_to_4_point_imag_7;
wire [31:0]point_8_to_4_point_imag_8,point_8_to_4_point_imag_9,point_8_to_4_point_imag_10,point_8_to_4_point_imag_11;
wire [31:0]point_8_to_4_point_imag_12,point_8_to_4_point_imag_13,point_8_to_4_point_imag_14,point_8_to_4_point_imag_15;

wire [31:0]point_4_to_2_point_real_0,point_4_to_2_point_real_1,point_4_to_2_point_real_2,point_4_to_2_point_real_3;
wire [31:0]point_4_to_2_point_real_4,point_4_to_2_point_real_5,point_4_to_2_point_real_6,point_4_to_2_point_real_7;
wire [31:0]point_4_to_2_point_real_8,point_4_to_2_point_real_9,point_4_to_2_point_real_10,point_4_to_2_point_real_11;
wire [31:0]point_4_to_2_point_real_12,point_4_to_2_point_real_13,point_4_to_2_point_real_14,point_4_to_2_point_real_15;

wire [31:0]point_4_to_2_point_imag_0,point_4_to_2_point_imag_1,point_4_to_2_point_imag_2,point_4_to_2_point_imag_3;
wire [31:0]point_4_to_2_point_imag_4,point_4_to_2_point_imag_5,point_4_to_2_point_imag_6,point_4_to_2_point_imag_7;
wire [31:0]point_4_to_2_point_imag_8,point_4_to_2_point_imag_9,point_4_to_2_point_imag_10,point_4_to_2_point_imag_11;
wire [31:0]point_4_to_2_point_imag_12,point_4_to_2_point_imag_13,point_4_to_2_point_imag_14,point_4_to_2_point_imag_15;

wire [31:0]point_2_to_out_real_0,point_2_to_out_real_1,point_2_to_out_real_2,point_2_to_out_real_3;
wire [31:0]point_2_to_out_real_4,point_2_to_out_real_5,point_2_to_out_real_6,point_2_to_out_real_7;
wire [31:0]point_2_to_out_real_8,point_2_to_out_real_9,point_2_to_out_real_10,point_2_to_out_real_11;
wire [31:0]point_2_to_out_real_12,point_2_to_out_real_13,point_2_to_out_real_14,point_2_to_out_real_15;

wire [31:0]point_2_to_out_imag_0,point_2_to_out_imag_1,point_2_to_out_imag_2,point_2_to_out_imag_3;
wire [31:0]point_2_to_out_imag_4,point_2_to_out_imag_5,point_2_to_out_imag_6,point_2_to_out_imag_7;
wire [31:0]point_2_to_out_imag_8,point_2_to_out_imag_9,point_2_to_out_imag_10,point_2_to_out_imag_11;
wire [31:0]point_2_to_out_imag_12,point_2_to_out_imag_13,point_2_to_out_imag_14,point_2_to_out_imag_15;


assign fft_d0={point_2_to_out_real_0[23:8],point_2_to_out_imag_0[23:8]};
assign fft_d1={point_2_to_out_real_8[23:8],point_2_to_out_imag_8[23:8]};
assign fft_d2={point_2_to_out_real_4[23:8],point_2_to_out_imag_4[23:8]};
assign fft_d3={point_2_to_out_real_12[23:8],point_2_to_out_imag_12[23:8]};
assign fft_d4={point_2_to_out_real_2[23:8],point_2_to_out_imag_2[23:8]};
assign fft_d5={point_2_to_out_real_10[23:8],point_2_to_out_imag_10[23:8]};
assign fft_d6={point_2_to_out_real_6[23:8],point_2_to_out_imag_6[23:8]};
assign fft_d7={point_2_to_out_real_14[23:8],point_2_to_out_imag_14[23:8]};
assign fft_d8={point_2_to_out_real_1[23:8],point_2_to_out_imag_1[23:8]};
assign fft_d9={point_2_to_out_real_9[23:8],point_2_to_out_imag_9[23:8]};
assign fft_d10={point_2_to_out_real_5[23:8],point_2_to_out_imag_5[23:8]};
assign fft_d11={point_2_to_out_real_13[23:8],point_2_to_out_imag_13[23:8]};
assign fft_d12={point_2_to_out_real_3[23:8],point_2_to_out_imag_3[23:8]};
assign fft_d13={point_2_to_out_real_11[23:8],point_2_to_out_imag_11[23:8]};
assign fft_d14={point_2_to_out_real_7[23:8],point_2_to_out_imag_7[23:8]};
assign fft_d15={point_2_to_out_real_15[23:8],point_2_to_out_imag_15[23:8]};

Serial_to_Parallel  a(
.clk(clk),
.rst(rst),
.fir_valid(fir_valid),
.fir_data(fir_d),
.valid(fft_valid),
.data_out_0(Parallel_to_16_point_0),
.data_out_1(Parallel_to_16_point_1),
.data_out_2(Parallel_to_16_point_2),
.data_out_3(Parallel_to_16_point_3),
.data_out_4(Parallel_to_16_point_4),
.data_out_5(Parallel_to_16_point_5),
.data_out_6(Parallel_to_16_point_6),
.data_out_7(Parallel_to_16_point_7),
.data_out_8(Parallel_to_16_point_8),
.data_out_9(Parallel_to_16_point_9),
.data_out_10(Parallel_to_16_point_10),
.data_out_11(Parallel_to_16_point_11),
.data_out_12(Parallel_to_16_point_12),
.data_out_13(Parallel_to_16_point_13),
.data_out_14(Parallel_to_16_point_14),
.data_out_15(Parallel_to_16_point_15)
);


 butterfly_16_point b(
.data_0_real(Parallel_to_16_point_0),
.data_0_imag(16'd0),
.data_1_real(Parallel_to_16_point_1),
.data_1_imag(16'd0),
.data_2_real(Parallel_to_16_point_2),
.data_2_imag(16'd0),
.data_3_real(Parallel_to_16_point_3),
.data_3_imag(16'd0),
.data_4_real(Parallel_to_16_point_4),
.data_4_imag(16'd0),
.data_5_real(Parallel_to_16_point_5),
.data_5_imag(16'd0),
.data_6_real(Parallel_to_16_point_6),
.data_6_imag(16'd0),
.data_7_real(Parallel_to_16_point_7),
.data_7_imag(16'd0),
.data_8_real(Parallel_to_16_point_8),
.data_8_imag(16'd0),
.data_9_real(Parallel_to_16_point_9),
.data_9_imag(16'd0),
.data_10_real(Parallel_to_16_point_10),
.data_10_imag(16'd0),
.data_11_real(Parallel_to_16_point_11),
.data_11_imag(16'd0),
.data_12_real(Parallel_to_16_point_12),
.data_12_imag(16'd0),
.data_13_real(Parallel_to_16_point_13),
.data_13_imag(16'd0),
.data_14_real(Parallel_to_16_point_14),
.data_14_imag(16'd0),
.data_15_real(Parallel_to_16_point_15),
.data_15_imag(16'd0),

.fft_0_real(point_16_to_8_point_real_0),
.fft_0_imag(point_16_to_8_point_imag_0),
.fft_1_real(point_16_to_8_point_real_1),
.fft_1_imag(point_16_to_8_point_imag_1),
.fft_2_real(point_16_to_8_point_real_2),
.fft_2_imag(point_16_to_8_point_imag_2),
.fft_3_real(point_16_to_8_point_real_3),
.fft_3_imag(point_16_to_8_point_imag_3),
.fft_4_real(point_16_to_8_point_real_4),
.fft_4_imag(point_16_to_8_point_imag_4),
.fft_5_real(point_16_to_8_point_real_5),
.fft_5_imag(point_16_to_8_point_imag_5),
.fft_6_real(point_16_to_8_point_real_6),
.fft_6_imag(point_16_to_8_point_imag_6),
.fft_7_real(point_16_to_8_point_real_7),
.fft_7_imag(point_16_to_8_point_imag_7),
.fft_8_real(point_16_to_8_point_real_8),
.fft_8_imag(point_16_to_8_point_imag_8),
.fft_9_real(point_16_to_8_point_real_9),
.fft_9_imag(point_16_to_8_point_imag_9),
.fft_10_real(point_16_to_8_point_real_10),
.fft_10_imag(point_16_to_8_point_imag_10),
.fft_11_real(point_16_to_8_point_real_11),
.fft_11_imag(point_16_to_8_point_imag_11),
.fft_12_real(point_16_to_8_point_real_12),
.fft_12_imag(point_16_to_8_point_imag_12),
.fft_13_real(point_16_to_8_point_real_13),
.fft_13_imag(point_16_to_8_point_imag_13),
.fft_14_real(point_16_to_8_point_real_14),
.fft_14_imag(point_16_to_8_point_imag_14),
.fft_15_real(point_16_to_8_point_real_15),
.fft_15_imag(point_16_to_8_point_imag_15)

);

butterfly_8_point c0(

.data_0_real(point_16_to_8_point_real_0),
.data_0_imag(point_16_to_8_point_imag_0),
.data_1_real(point_16_to_8_point_real_1),
.data_1_imag(point_16_to_8_point_imag_1),
.data_2_real(point_16_to_8_point_real_2),
.data_2_imag(point_16_to_8_point_imag_2),
.data_3_real(point_16_to_8_point_real_3),
.data_3_imag(point_16_to_8_point_imag_3),
.data_4_real(point_16_to_8_point_real_4),
.data_4_imag(point_16_to_8_point_imag_4),
.data_5_real(point_16_to_8_point_real_5),
.data_5_imag(point_16_to_8_point_imag_5),
.data_6_real(point_16_to_8_point_real_6),
.data_6_imag(point_16_to_8_point_imag_6),
.data_7_real(point_16_to_8_point_real_7),
.data_7_imag(point_16_to_8_point_imag_7),

.fft_0_real(point_8_to_4_point_real_0),
.fft_0_imag(point_8_to_4_point_imag_0),
.fft_1_real(point_8_to_4_point_real_1),
.fft_1_imag(point_8_to_4_point_imag_1),
.fft_2_real(point_8_to_4_point_real_2),
.fft_2_imag(point_8_to_4_point_imag_2),
.fft_3_real(point_8_to_4_point_real_3),
.fft_3_imag(point_8_to_4_point_imag_3),
.fft_4_real(point_8_to_4_point_real_4),
.fft_4_imag(point_8_to_4_point_imag_4),
.fft_5_real(point_8_to_4_point_real_5),
.fft_5_imag(point_8_to_4_point_imag_5),
.fft_6_real(point_8_to_4_point_real_6),
.fft_6_imag(point_8_to_4_point_imag_6),
.fft_7_real(point_8_to_4_point_real_7),
.fft_7_imag(point_8_to_4_point_imag_7)

);

butterfly_8_point c1(

.data_0_real(point_16_to_8_point_real_8),
.data_0_imag(point_16_to_8_point_imag_8),
.data_1_real(point_16_to_8_point_real_9),
.data_1_imag(point_16_to_8_point_imag_9),
.data_2_real(point_16_to_8_point_real_10),
.data_2_imag(point_16_to_8_point_imag_10),
.data_3_real(point_16_to_8_point_real_11),
.data_3_imag(point_16_to_8_point_imag_11),
.data_4_real(point_16_to_8_point_real_12),
.data_4_imag(point_16_to_8_point_imag_12),
.data_5_real(point_16_to_8_point_real_13),
.data_5_imag(point_16_to_8_point_imag_13),
.data_6_real(point_16_to_8_point_real_14),
.data_6_imag(point_16_to_8_point_imag_14),
.data_7_real(point_16_to_8_point_real_15),
.data_7_imag(point_16_to_8_point_imag_15),

.fft_0_real(point_8_to_4_point_real_8),
.fft_0_imag(point_8_to_4_point_imag_8),
.fft_1_real(point_8_to_4_point_real_9),
.fft_1_imag(point_8_to_4_point_imag_9),
.fft_2_real(point_8_to_4_point_real_10),
.fft_2_imag(point_8_to_4_point_imag_10),
.fft_3_real(point_8_to_4_point_real_11),
.fft_3_imag(point_8_to_4_point_imag_11),
.fft_4_real(point_8_to_4_point_real_12),
.fft_4_imag(point_8_to_4_point_imag_12),
.fft_5_real(point_8_to_4_point_real_13),
.fft_5_imag(point_8_to_4_point_imag_13),
.fft_6_real(point_8_to_4_point_real_14),
.fft_6_imag(point_8_to_4_point_imag_14),
.fft_7_real(point_8_to_4_point_real_15),
.fft_7_imag(point_8_to_4_point_imag_15)

);

butterfly_4_point d0(
.data_0_real(point_8_to_4_point_real_0),
.data_0_imag(point_8_to_4_point_imag_0),
.data_1_real(point_8_to_4_point_real_1),
.data_1_imag(point_8_to_4_point_imag_1),
.data_2_real(point_8_to_4_point_real_2),
.data_2_imag(point_8_to_4_point_imag_2),
.data_3_real(point_8_to_4_point_real_3),
.data_3_imag(point_8_to_4_point_imag_3),

.fft_0_real(point_4_to_2_point_real_0),
.fft_0_imag(point_4_to_2_point_imag_0),
.fft_1_real(point_4_to_2_point_real_1),
.fft_1_imag(point_4_to_2_point_imag_1),
.fft_2_real(point_4_to_2_point_real_2),
.fft_2_imag(point_4_to_2_point_imag_2),
.fft_3_real(point_4_to_2_point_real_3),
.fft_3_imag(point_4_to_2_point_imag_3)
);

butterfly_4_point d1(
.data_0_real(point_8_to_4_point_real_4),
.data_0_imag(point_8_to_4_point_imag_4),
.data_1_real(point_8_to_4_point_real_5),
.data_1_imag(point_8_to_4_point_imag_5),
.data_2_real(point_8_to_4_point_real_6),
.data_2_imag(point_8_to_4_point_imag_6),
.data_3_real(point_8_to_4_point_real_7),
.data_3_imag(point_8_to_4_point_imag_7),

.fft_0_real(point_4_to_2_point_real_4),
.fft_0_imag(point_4_to_2_point_imag_4),
.fft_1_real(point_4_to_2_point_real_5),
.fft_1_imag(point_4_to_2_point_imag_5),
.fft_2_real(point_4_to_2_point_real_6),
.fft_2_imag(point_4_to_2_point_imag_6),
.fft_3_real(point_4_to_2_point_real_7),
.fft_3_imag(point_4_to_2_point_imag_7)
);

butterfly_4_point d2(
.data_0_real(point_8_to_4_point_real_8),
.data_0_imag(point_8_to_4_point_imag_8),
.data_1_real(point_8_to_4_point_real_9),
.data_1_imag(point_8_to_4_point_imag_9),
.data_2_real(point_8_to_4_point_real_10),
.data_2_imag(point_8_to_4_point_imag_10),
.data_3_real(point_8_to_4_point_real_11),
.data_3_imag(point_8_to_4_point_imag_11),

.fft_0_real(point_4_to_2_point_real_8),
.fft_0_imag(point_4_to_2_point_imag_8),
.fft_1_real(point_4_to_2_point_real_9),
.fft_1_imag(point_4_to_2_point_imag_9),
.fft_2_real(point_4_to_2_point_real_10),
.fft_2_imag(point_4_to_2_point_imag_10),
.fft_3_real(point_4_to_2_point_real_11),
.fft_3_imag(point_4_to_2_point_imag_11)
);

butterfly_4_point d3(
.data_0_real(point_8_to_4_point_real_12),
.data_0_imag(point_8_to_4_point_imag_12),
.data_1_real(point_8_to_4_point_real_13),
.data_1_imag(point_8_to_4_point_imag_13),
.data_2_real(point_8_to_4_point_real_14),
.data_2_imag(point_8_to_4_point_imag_14),
.data_3_real(point_8_to_4_point_real_15),
.data_3_imag(point_8_to_4_point_imag_15),

.fft_0_real(point_4_to_2_point_real_12),
.fft_0_imag(point_4_to_2_point_imag_12),
.fft_1_real(point_4_to_2_point_real_13),
.fft_1_imag(point_4_to_2_point_imag_13),
.fft_2_real(point_4_to_2_point_real_14),
.fft_2_imag(point_4_to_2_point_imag_14),
.fft_3_real(point_4_to_2_point_real_15),
.fft_3_imag(point_4_to_2_point_imag_15)
);

butterfly_2_point e0(
.data_0_real(point_4_to_2_point_real_0),
.data_0_imag(point_4_to_2_point_imag_0),
.data_1_real(point_4_to_2_point_real_1),
.data_1_imag(point_4_to_2_point_imag_1),

.fft_0_real(point_2_to_out_real_0),
.fft_0_imag(point_2_to_out_imag_0),
.fft_1_real(point_2_to_out_real_1),
.fft_1_imag(point_2_to_out_imag_1)
);

butterfly_2_point e1(
.data_0_real(point_4_to_2_point_real_2),
.data_0_imag(point_4_to_2_point_imag_2),
.data_1_real(point_4_to_2_point_real_3),
.data_1_imag(point_4_to_2_point_imag_3),

.fft_0_real(point_2_to_out_real_2),
.fft_0_imag(point_2_to_out_imag_2),
.fft_1_real(point_2_to_out_real_3),
.fft_1_imag(point_2_to_out_imag_3)
);

butterfly_2_point e2(
.data_0_real(point_4_to_2_point_real_4),
.data_0_imag(point_4_to_2_point_imag_4),
.data_1_real(point_4_to_2_point_real_5),
.data_1_imag(point_4_to_2_point_imag_5),

.fft_0_real(point_2_to_out_real_4),
.fft_0_imag(point_2_to_out_imag_4),
.fft_1_real(point_2_to_out_real_5),
.fft_1_imag(point_2_to_out_imag_5)
);

butterfly_2_point e3(
.data_0_real(point_4_to_2_point_real_6),
.data_0_imag(point_4_to_2_point_imag_6),
.data_1_real(point_4_to_2_point_real_7),
.data_1_imag(point_4_to_2_point_imag_7),

.fft_0_real(point_2_to_out_real_6),
.fft_0_imag(point_2_to_out_imag_6),
.fft_1_real(point_2_to_out_real_7),
.fft_1_imag(point_2_to_out_imag_7)
);

butterfly_2_point e4(
.data_0_real(point_4_to_2_point_real_8),
.data_0_imag(point_4_to_2_point_imag_8),
.data_1_real(point_4_to_2_point_real_9),
.data_1_imag(point_4_to_2_point_imag_9),

.fft_0_real(point_2_to_out_real_8),
.fft_0_imag(point_2_to_out_imag_8),
.fft_1_real(point_2_to_out_real_9),
.fft_1_imag(point_2_to_out_imag_9)
);

butterfly_2_point e5(
.data_0_real(point_4_to_2_point_real_10),
.data_0_imag(point_4_to_2_point_imag_10),
.data_1_real(point_4_to_2_point_real_11),
.data_1_imag(point_4_to_2_point_imag_11),

.fft_0_real(point_2_to_out_real_10),
.fft_0_imag(point_2_to_out_imag_10),
.fft_1_real(point_2_to_out_real_11),
.fft_1_imag(point_2_to_out_imag_11)
);

butterfly_2_point e6(
.data_0_real(point_4_to_2_point_real_12),
.data_0_imag(point_4_to_2_point_imag_12),
.data_1_real(point_4_to_2_point_real_13),
.data_1_imag(point_4_to_2_point_imag_13),

.fft_0_real(point_2_to_out_real_12),
.fft_0_imag(point_2_to_out_imag_12),
.fft_1_real(point_2_to_out_real_13),
.fft_1_imag(point_2_to_out_imag_13)
);

butterfly_2_point e7(
.data_0_real(point_4_to_2_point_real_14),
.data_0_imag(point_4_to_2_point_imag_14),
.data_1_real(point_4_to_2_point_real_15),
.data_1_imag(point_4_to_2_point_imag_15),

.fft_0_real(point_2_to_out_real_14),
.fft_0_imag(point_2_to_out_imag_14),
.fft_1_real(point_2_to_out_real_15),
.fft_1_imag(point_2_to_out_imag_15)
);

endmodule

/*real part of the reference 
parameter W0_real=32'h00010000      //The real part of the reference table about COS(x)+i*SIN(x) value , 0: 001
parameter W1_real=32'h0000EC83      //The real part of the reference table about COS(x)+i*SIN(x) value , 1: 9.238739e-001
parameter W2_real=32'h0000B504      //The real part of the reference table about COS(x)+i*SIN(x) value , 2: 7.070923e-001
parameter W3_real=32'h000061F7      //The real part of the reference table about COS(x)+i*SIN(x) value , 3: 3.826752e-001
parameter W4_real=32'h00000000      //The real part of the reference table about COS(x)+i*SIN(x) value , 4: 000
parameter W5_real=32'hFFFF9E09      //The real part of the reference table about COS(x)+i*SIN(x) value , 5: -3.826752e-001
parameter W6_real=32'hFFFF4AFC      //The real part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001
parameter W7_real=32'hFFFF137D      //The real part of the reference table about COS(x)+i*SIN(x) value , 7: -9.238739e-001
*/

/*imag part of the reference
parameter W0_imag=32'h00000000      //The imag part of the reference table about COS(x)+i*SIN(x) value , 0: 000
parameter W1_imag=32'hFFFF9E09      //The imag part of the reference table about COS(x)+i*SIN(x) value , 1: -3.826752e-001
parameter W2_imag=32'hFFFF4AFC      //The imag part of the reference table about COS(x)+i*SIN(x) value , 2: -7.070923e-001
parameter W3_imag=32'hFFFF137D      //The imag part of the reference table about COS(x)+i*SIN(x) value , 3: -9.238739e-001
parameter W4_imag=32'hFFFF0000      //The imag part of the reference table about COS(x)+i*SIN(x) value , 4: -01
parameter W5_imag=32'hFFFF137D      //The imag part of the reference table about COS(x)+i*SIN(x) value , 5: -9.238739e-001
parameter W6_imag=32'hFFFF4AFC      //The imag part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001
parameter W7_imag=32'hFFFF9E09      //The imag part of the reference table about COS(x)+i*SIN(x) value , 7: -3.826752e-001
*/

