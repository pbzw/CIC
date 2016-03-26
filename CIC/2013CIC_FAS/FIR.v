module FIR(
input clk,
input rst,
input enable,
input [15:0]data_in,
output [15:0]Y,
output valid_out
);

parameter signed [19:0] FIR_C00 = 20'hFFF9E ;     //The FIR_coefficient value 0: -1.495361e-003
parameter signed [19:0] FIR_C01 = 20'hFFF86 ;     //The FIR_coefficient value 1: -1.861572e-003
parameter signed [19:0] FIR_C02 = 20'hFFFA7 ;     //The FIR_coefficient value 2: -1.358032e-003
parameter signed [19:0] FIR_C03 = 20'h0003B ;    //The FIR_coefficient value 3: 9.002686e-004
parameter signed [19:0] FIR_C04 = 20'h0014B ;    //The FIR_coefficient value 4: 5.050659e-003
parameter signed [19:0] FIR_C05 = 20'h0024A ;    //The FIR_coefficient value 5: 8.941650e-003
parameter signed [19:0] FIR_C06 = 20'h00222 ;    //The FIR_coefficient value 6: 8.331299e-003
parameter signed [19:0] FIR_C07 = 20'hFFFE4 ;     //The FIR_coefficient value 7: -4.272461e-004
parameter signed [19:0] FIR_C08 = 20'hFFBC5 ;     //The FIR_coefficient value 8: -1.652527e-002
parameter signed [19:0] FIR_C09 = 20'hFF7CA ;     //The FIR_coefficient value 9: -3.207397e-002
parameter signed [19:0] FIR_C10 = 20'hFF74E ;     //The FIR_coefficient value 10: -3.396606e-002
parameter signed [19:0] FIR_C11 = 20'hFFD74 ;     //The FIR_coefficient value 11: -9.948730e-003
parameter signed [19:0] FIR_C12 = 20'h00B1A ;    //The FIR_coefficient value 12: 4.336548e-002
parameter signed [19:0] FIR_C13 = 20'h01DAC ;    //The FIR_coefficient value 13: 1.159058e-001
parameter signed [19:0] FIR_C14 = 20'h02F9E ;    //The FIR_coefficient value 14: 1.860046e-001
parameter signed [19:0] FIR_C15 = 20'h03AA9 ;    //The FIR_coefficient value 15: 2.291412e-001
parameter signed [19:0] FIR_C16 = 20'h03AA9 ;    //The FIR_coefficient value 16: 2.291412e-001
parameter signed [19:0] FIR_C17 = 20'h02F9E ;    //The FIR_coefficient value 17: 1.860046e-001
parameter signed [19:0] FIR_C18 = 20'h01DAC ;    //The FIR_coefficient value 18: 1.159058e-001
parameter signed [19:0] FIR_C19 = 20'h00B1A ;    //The FIR_coefficient value 19: 4.336548e-002
parameter signed [19:0] FIR_C20 = 20'hFFD74 ;     //The FIR_coefficient value 20: -9.948730e-003
parameter signed [19:0] FIR_C21 = 20'hFF74E ;     //The FIR_coefficient value 21: -3.396606e-002
parameter signed [19:0] FIR_C22 = 20'hFF7CA ;     //The FIR_coefficient value 22: -3.207397e-002
parameter signed [19:0] FIR_C23 = 20'hFFBC5 ;     //The FIR_coefficient value 23: -1.652527e-002
parameter signed [19:0] FIR_C24 = 20'hFFFE4 ;     //The FIR_coefficient value 24: -4.272461e-004
parameter signed [19:0] FIR_C25 = 20'h00222 ;    //The FIR_coefficient value 25: 8.331299e-003
parameter signed [19:0] FIR_C26 = 20'h0024A ;    //The FIR_coefficient value 26: 8.941650e-003
parameter signed [19:0] FIR_C27 = 20'h0014B ;    //The FIR_coefficient value 27: 5.050659e-003
parameter signed [19:0] FIR_C28 = 20'h0003B ;    //The FIR_coefficient value 28: 9.002686e-004
parameter signed [19:0] FIR_C29 = 20'hFFFA7 ;     //The FIR_coefficient value 29: -1.358032e-003
parameter signed [19:0] FIR_C30 = 20'hFFF86 ;     //The FIR_coefficient value 30: -1.861572e-003
parameter signed [19:0] FIR_C31 = 20'hFFF9E ;     //The FIR_coefficient value 31: -1.495361e-003

wire done;

wire [15:0]data_out_0,data_out_1,data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,data_out_7,data_out_8,data_out_9;
wire [15:0]data_out_10,data_out_11,data_out_12,data_out_13,data_out_14,data_out_15,data_out_16,data_out_17,data_out_18,data_out_19;
wire [15:0]data_out_20,data_out_21,data_out_22,data_out_23,data_out_24,data_out_25,data_out_26,data_out_27,data_out_28,data_out_29;
wire [15:0]data_out_30,data_out_31,data_out_32;

wire [31:0]mul_out_0,mul_out_1,mul_out_2,mul_out_3,mul_out_4,mul_out_5,mul_out_6,mul_out_7,mul_out_8,mul_out_9
,mul_out_10,mul_out_11,mul_out_12,mul_out_13,mul_out_14,mul_out_15,mul_out_16,mul_out_17,mul_out_18,mul_out_19
,mul_out_20,mul_out_21,mul_out_22,mul_out_23,mul_out_24,mul_out_25,mul_out_26,mul_out_27,mul_out_28,mul_out_29
,mul_out_30,mul_out_31;
wire [31:0]sum;
wire [31:0]valid;
assign valid_out=(valid==32'hffffffff);

M_A M0(
.clk(clk),
.rst(rst),
.enable(enable),
.data_in(data_in),
.coefficient(FIR_C00),
.mul_out(mul_out_0),
.data_out(data_out_0),
.valid(valid[0])
);

M_A M1(
.clk(clk),
.rst(rst),
.enable(valid[0]),
.data_in(data_out_0),
.coefficient(FIR_C01),
.mul_out(mul_out_1),
.data_out(data_out_1),
.valid(valid[1])
);

M_A M2(
.clk(clk),
.rst(rst),
.enable(valid[1]),
.data_in(data_out_1),
.coefficient(FIR_C02),
.mul_out(mul_out_2),
.data_out(data_out_2),
.valid(valid[2])
);

M_A M3(
.clk(clk),
.rst(rst),
.enable(valid[2]),
.data_in(data_out_2),
.coefficient(FIR_C03),
.mul_out(mul_out_3),
.data_out(data_out_3),
.valid(valid[3])
);

M_A M4(
.clk(clk),
.rst(rst),
.enable(valid[3]),
.data_in(data_out_3),
.coefficient(FIR_C04),
.mul_out(mul_out_4),
.data_out(data_out_4),
.valid(valid[4])
);

M_A M5(
.clk(clk),
.rst(rst),
.enable(valid[4]),
.data_in(data_out_4),
.coefficient(FIR_C05),
.mul_out(mul_out_5),
.data_out(data_out_5),
.valid(valid[5])
);

M_A M6(
.clk(clk),
.rst(rst),
.enable(valid[5]),
.data_in(data_out_5),
.coefficient(FIR_C06),
.mul_out(mul_out_6),
.data_out(data_out_6),
.valid(valid[6])
);

M_A M7(
.clk(clk),
.rst(rst),
.enable(valid[6]),
.data_in(data_out_6),
.coefficient(FIR_C07),
.mul_out(mul_out_7),
.data_out(data_out_7),
.valid(valid[7])
);

M_A M8(
.clk(clk),
.rst(rst),
.enable(valid[7]),
.data_in(data_out_7),
.coefficient(FIR_C08),
.mul_out(mul_out_8),
.data_out(data_out_8),
.valid(valid[8])
);

M_A M9(
.clk(clk),
.rst(rst),
.enable(valid[8]),
.data_in(data_out_8),
.coefficient(FIR_C09),
.mul_out(mul_out_9),
.data_out(data_out_9),
.valid(valid[9])
);

M_A M10(
.clk(clk),
.rst(rst),
.enable(valid[9]),
.data_in(data_out_9),
.coefficient(FIR_C10),
.mul_out(mul_out_10),
.data_out(data_out_10),
.valid(valid[10])
);

M_A M11(
.clk(clk),
.rst(rst),
.enable(valid[10]),
.data_in(data_out_10),
.coefficient(FIR_C11),
.mul_out(mul_out_11),
.data_out(data_out_11),
.valid(valid[11])
);

M_A M12(
.clk(clk),
.rst(rst),
.enable(valid[11]),
.data_in(data_out_11),
.coefficient(FIR_C12),
.mul_out(mul_out_12),
.data_out(data_out_12),
.valid(valid[12])
);

M_A M13(
.clk(clk),
.rst(rst),
.enable(valid[12]),
.data_in(data_out_12),
.coefficient(FIR_C13),
.mul_out(mul_out_13),
.data_out(data_out_13),
.valid(valid[13])
);

M_A M14(
.clk(clk),
.rst(rst),
.enable(valid[13]),
.data_in(data_out_13),
.coefficient(FIR_C14),
.mul_out(mul_out_14),
.data_out(data_out_14),
.valid(valid[14])
);

M_A M15(
.clk(clk),
.rst(rst),
.enable(valid[14]),
.data_in(data_out_14),
.coefficient(FIR_C15),
.mul_out(mul_out_15),
.data_out(data_out_15),
.valid(valid[15])
);


M_A M16(
.clk(clk),
.rst(rst),
.enable(valid[15]),
.data_in(data_out_15),
.coefficient(FIR_C16),
.mul_out(mul_out_16),
.data_out(data_out_16),
.valid(valid[16])
);
M_A M17(
.clk(clk),
.rst(rst),
.enable(valid[16]),
.data_in(data_out_16),
.coefficient(FIR_C17),
.mul_out(mul_out_17),
.data_out(data_out_17),
.valid(valid[17])
);

M_A M18(
.clk(clk),
.rst(rst),
.enable(valid[17]),
.data_in(data_out_17),
.coefficient(FIR_C18),
.mul_out(mul_out_18),
.data_out(data_out_18),
.valid(valid[18])
);

M_A M19(
.clk(clk),
.rst(rst),
.enable(valid[18]),
.data_in(data_out_18),
.coefficient(FIR_C19),
.mul_out(mul_out_19),
.data_out(data_out_19),
.valid(valid[19])
);

M_A M20(
.clk(clk),
.rst(rst),
.enable(valid[19]),
.data_in(data_out_19),
.coefficient(FIR_C20),
.mul_out(mul_out_20),
.data_out(data_out_20),
.valid(valid[20])
);
M_A M21(
.clk(clk),
.rst(rst),
.enable(valid[20]),
.data_in(data_out_20),
.coefficient(FIR_C21),
.mul_out(mul_out_21),
.data_out(data_out_21),
.valid(valid[21])
);

M_A M22(
.clk(clk),
.rst(rst),
.enable(valid[21]),
.data_in(data_out_21),
.coefficient(FIR_C22),
.mul_out(mul_out_22),
.data_out(data_out_22),
.valid(valid[22])
);

M_A M23(
.clk(clk),
.rst(rst),
.enable(valid[22]),
.data_in(data_out_22),
.coefficient(FIR_C23),
.mul_out(mul_out_23),
.data_out(data_out_23),
.valid(valid[23])
);

M_A M24(
.clk(clk),
.rst(rst),
.enable(valid[23]),
.data_in(data_out_23),
.coefficient(FIR_C24),
.mul_out(mul_out_24),
.data_out(data_out_24),
.valid(valid[24])
);

M_A M25(
.clk(clk),
.rst(rst),
.enable(valid[24]),
.data_in(data_out_24),
.coefficient(FIR_C25),
.mul_out(mul_out_25),
.data_out(data_out_25),
.valid(valid[25])
);


M_A M26(
.clk(clk),
.rst(rst),
.enable(valid[25]),
.data_in(data_out_25),
.coefficient(FIR_C26),
.mul_out(mul_out_26),
.data_out(data_out_26),
.valid(valid[26])
);
M_A M27(
.clk(clk),
.rst(rst),
.enable(valid[26]),
.data_in(data_out_26),
.coefficient(FIR_C27),
.mul_out(mul_out_27),
.data_out(data_out_27),
.valid(valid[27])
);

M_A M28(
.clk(clk),
.rst(rst),
.enable(valid[27]),
.data_in(data_out_27),
.coefficient(FIR_C28),
.mul_out(mul_out_28),
.data_out(data_out_28),
.valid(valid[28])
);

M_A M29(
.clk(clk),
.rst(rst),
.enable(valid[28]),
.data_in(data_out_28),
.coefficient(FIR_C29),
.mul_out(mul_out_29),
.data_out(data_out_29),
.valid(valid[29])
);

M_A M30(
.clk(clk),
.rst(rst),
.enable(valid[29]),
.data_in(data_out_29),
.coefficient(FIR_C30),
.mul_out(mul_out_30),
.data_out(data_out_30),
.valid(valid[30])
);

M_A M31(
.clk(clk),
.rst(rst),
.enable(valid[30]),
.data_in(data_out_30),
.coefficient(FIR_C31),
.mul_out(mul_out_31),
.data_out(),
.valid(valid[31])
);
assign Y=sum[31]?sum[31:16]+1'b1:sum[31:16];

assign sum=
((mul_out_0+mul_out_1)+
(mul_out_2+mul_out_3))+

((mul_out_4+mul_out_5)+
(mul_out_6+mul_out_7))+

(mul_out_8+mul_out_9)+
(mul_out_10+mul_out_11)+
(mul_out_12+mul_out_13)+
(mul_out_14+mul_out_15)+
(mul_out_16+mul_out_17)+
(mul_out_18+mul_out_19)+
(mul_out_20+mul_out_21)+
(mul_out_22+mul_out_23)+
(mul_out_24+mul_out_25)+
(mul_out_26+mul_out_27)+
(mul_out_28+mul_out_29)+
(mul_out_30+mul_out_31);
endmodule
