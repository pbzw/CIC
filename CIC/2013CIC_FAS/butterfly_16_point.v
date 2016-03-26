module butterfly_16_point(

input [15:0]data_0_real,
input [15:0]data_0_imag,
input [15:0]data_1_real,
input [15:0]data_1_imag,
input [15:0]data_2_real,
input [15:0]data_2_imag,
input [15:0]data_3_real,
input [15:0]data_3_imag,
input [15:0]data_4_real,
input [15:0]data_4_imag,
input [15:0]data_5_real,
input [15:0]data_5_imag,
input [15:0]data_6_real,
input [15:0]data_6_imag,
input [15:0]data_7_real,
input [15:0]data_7_imag,
input [15:0]data_8_real,
input [15:0]data_8_imag,
input [15:0]data_9_real,
input [15:0]data_9_imag,
input [15:0]data_10_real,
input [15:0]data_10_imag,
input [15:0]data_11_real,
input [15:0]data_11_imag,
input [15:0]data_12_real,
input [15:0]data_12_imag,
input [15:0]data_13_real,
input [15:0]data_13_imag,
input [15:0]data_14_real,
input [15:0]data_14_imag,
input [15:0]data_15_real,
input [15:0]data_15_imag,

output [31:0]fft_0_real,
output [31:0]fft_0_imag,
output [31:0]fft_1_real,
output [31:0]fft_1_imag,
output [31:0]fft_2_real,
output [31:0]fft_2_imag,
output [31:0]fft_3_real,
output [31:0]fft_3_imag,
output [31:0]fft_4_real,
output [31:0]fft_4_imag,
output [31:0]fft_5_real,
output [31:0]fft_5_imag,
output [31:0]fft_6_real,
output [31:0]fft_6_imag,
output [31:0]fft_7_real,
output [31:0]fft_7_imag,
output [31:0]fft_8_real,
output [31:0]fft_8_imag,
output [31:0]fft_9_real,
output [31:0]fft_9_imag,
output [31:0]fft_10_real,
output [31:0]fft_10_imag,
output [31:0]fft_11_real,
output [31:0]fft_11_imag,
output [31:0]fft_12_real,
output [31:0]fft_12_imag,
output [31:0]fft_13_real,
output [31:0]fft_13_imag,
output [31:0]fft_14_real,
output [31:0]fft_14_imag,
output [31:0]fft_15_real,
output [31:0]fft_15_imag

);
parameter W0_real=32'h00010000 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 0: 001
parameter W1_real=32'h0000EC83 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 1: 9.238739e-001
parameter W2_real=32'h0000B504 ;    //The real part of the reference table about COS(x)+i*SIN(x) value , 2: 7.070923e-001
parameter W3_real=32'h000061F7 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 3: 3.826752e-001
parameter W4_real=32'h00000000 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 4: 000
parameter W5_real=32'hFFFF9E09 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 5: -3.826752e-001
parameter W6_real=32'hFFFF4AFC ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001
parameter W7_real=32'hFFFF137D ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 7: -9.238739e-001
//**
parameter W0_imag=32'h00000000;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 0: 000
parameter W1_imag=32'hFFFF9E09;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 1: -3.826752e-001
parameter W2_imag=32'hFFFF4AFC;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 2: -7.070923e-001
parameter W3_imag=32'hFFFF137D;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 3: -9.238739e-001
parameter W4_imag=32'hFFFF0000;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 4: -01
parameter W5_imag=32'hFFFF137D;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 5: -9.238739e-001
parameter W6_imag=32'hFFFF4AFC;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001
parameter W7_imag=32'hFFFF9E09;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 7: -3.826752e-001

butterfly_base_16bits a0(
.X_real(data_0_real),
.X_imag(data_0_imag),
.Y_real(data_8_real),
.Y_imag(data_8_imag),
.Wn_real(W0_real),
.Wn_imag(W0_imag),
.fft_a_real(fft_0_real),
.fft_a_imag(fft_0_imag),
.fft_b_real(fft_8_real),
.fft_b_imag(fft_8_imag)
);

butterfly_base_16bits a1(
.X_real(data_1_real),
.X_imag(data_1_imag),
.Y_real(data_9_real),
.Y_imag(data_9_imag),
.Wn_real(W1_real),
.Wn_imag(W1_imag),
.fft_a_real(fft_1_real),
.fft_a_imag(fft_1_imag),
.fft_b_real(fft_9_real),
.fft_b_imag(fft_9_imag)
);

butterfly_base_16bits a2(
.X_real(data_2_real),
.X_imag(data_2_imag),
.Y_real(data_10_real),
.Y_imag(data_10_imag),
.Wn_real(W2_real),
.Wn_imag(W2_imag),
.fft_a_real(fft_2_real),
.fft_a_imag(fft_2_imag),
.fft_b_real(fft_10_real),
.fft_b_imag(fft_10_imag)
);

butterfly_base_16bits a3(
.X_real(data_3_real),
.X_imag(data_3_imag),
.Y_real(data_11_real),
.Y_imag(data_11_imag),
.Wn_real(W3_real),
.Wn_imag(W3_imag),
.fft_a_real(fft_3_real),
.fft_a_imag(fft_3_imag),
.fft_b_real(fft_11_real),
.fft_b_imag(fft_11_imag)
);

butterfly_base_16bits a4(
.X_real(data_4_real),
.X_imag(data_4_imag),
.Y_real(data_12_real),
.Y_imag(data_12_imag),
.Wn_real(W4_real),
.Wn_imag(W4_imag),
.fft_a_real(fft_4_real),
.fft_a_imag(fft_4_imag),
.fft_b_real(fft_12_real),
.fft_b_imag(fft_12_imag)
);

butterfly_base_16bits a5(
.X_real(data_5_real),
.X_imag(data_5_imag),
.Y_real(data_13_real),
.Y_imag(data_13_imag),
.Wn_real(W5_real),
.Wn_imag(W5_imag),
.fft_a_real(fft_5_real),
.fft_a_imag(fft_5_imag),
.fft_b_real(fft_13_real),
.fft_b_imag(fft_13_imag)
);

butterfly_base_16bits a6(
.X_real(data_6_real),
.X_imag(data_6_imag),
.Y_real(data_14_real),
.Y_imag(data_14_imag),
.Wn_real(W6_real),
.Wn_imag(W6_imag),
.fft_a_real(fft_6_real),
.fft_a_imag(fft_6_imag),
.fft_b_real(fft_14_real),
.fft_b_imag(fft_14_imag)
);

butterfly_base_16bits a7(
.X_real(data_7_real),
.X_imag(data_7_imag),
.Y_real(data_15_real),
.Y_imag(data_15_imag),
.Wn_real(W7_real),
.Wn_imag(W7_imag),
.fft_a_real(fft_7_real),
.fft_a_imag(fft_7_imag),
.fft_b_real(fft_15_real),
.fft_b_imag(fft_15_imag)
);

endmodule
