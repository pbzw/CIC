module butterfly_8_point(

input [31:0]data_0_real,
input [31:0]data_0_imag,
input [31:0]data_1_real,
input [31:0]data_1_imag,
input [31:0]data_2_real,
input [31:0]data_2_imag,
input [31:0]data_3_real,
input [31:0]data_3_imag,
input [31:0]data_4_real,
input [31:0]data_4_imag,
input [31:0]data_5_real,
input [31:0]data_5_imag,
input [31:0]data_6_real,
input [31:0]data_6_imag,
input [31:0]data_7_real,
input [31:0]data_7_imag,

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
output [31:0]fft_7_imag

);
parameter W0_real=32'h00010000;      //The real part of the reference table about COS(x)+i*SIN(x) value , 0: 001
parameter W2_real=32'h0000B504;      //The real part of the reference table about COS(x)+i*SIN(x) value , 2: 7.070923e-001
parameter W4_real=32'h00000000;      //The real part of the reference table about COS(x)+i*SIN(x) value , 4: 000
parameter W6_real=32'hFFFF4AFC;      //The real part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001

parameter W0_imag=32'h00000000;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 0: 000
parameter W2_imag=32'hFFFF4AFC;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 2: -7.070923e-001
parameter W4_imag=32'hFFFF0000;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 4: -01
parameter W6_imag=32'hFFFF4AFC;      //The imag part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001

butterfly_base a0(
.X_real(data_0_real),
.X_imag(data_0_imag),
.Y_real(data_4_real),
.Y_imag(data_4_imag),
.Wn_real(W0_real),
.Wn_imag(W0_imag),
.fft_a_real(fft_0_real),
.fft_a_imag(fft_0_imag),
.fft_b_real(fft_4_real),
.fft_b_imag(fft_4_imag)
);

butterfly_base a1(
.X_real(data_1_real),
.X_imag(data_1_imag),
.Y_real(data_5_real),
.Y_imag(data_5_imag),
.Wn_real(W2_real),
.Wn_imag(W2_imag),
.fft_a_real(fft_1_real),
.fft_a_imag(fft_1_imag),
.fft_b_real(fft_5_real),
.fft_b_imag(fft_5_imag)
);

butterfly_base a2(
.X_real(data_2_real),
.X_imag(data_2_imag),
.Y_real(data_6_real),
.Y_imag(data_6_imag),
.Wn_real(W4_real),
.Wn_imag(W4_imag),
.fft_a_real(fft_2_real),
.fft_a_imag(fft_2_imag),
.fft_b_real(fft_6_real),
.fft_b_imag(fft_6_imag)
);

butterfly_base a3(
.X_real(data_3_real),
.X_imag(data_3_imag),
.Y_real(data_7_real),
.Y_imag(data_7_imag),
.Wn_real(W6_real),
.Wn_imag(W6_imag),
.fft_a_real(fft_3_real),
.fft_a_imag(fft_3_imag),
.fft_b_real(fft_7_real),
.fft_b_imag(fft_7_imag)
);

endmodule
