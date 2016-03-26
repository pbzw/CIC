module butterfly_4_point(
input [31:0]data_0_real,
input [31:0]data_0_imag,
input [31:0]data_1_real,
input [31:0]data_1_imag,
input [31:0]data_2_real,
input [31:0]data_2_imag,
input [31:0]data_3_real,
input [31:0]data_3_imag,
output [31:0]fft_0_real,
output [31:0]fft_0_imag,
output [31:0]fft_1_real,
output [31:0]fft_1_imag,
output [31:0]fft_2_real,
output [31:0]fft_2_imag,
output [31:0]fft_3_real,
output [31:0]fft_3_imag

);

parameter W0_real=32'h00010000;
parameter W0_imag=32'h00000000;
parameter W4_real=32'h00000000;
parameter W4_imag=32'hFFFF0000;

butterfly_base a0(
.X_real(data_0_real),
.X_imag(data_0_imag),
.Y_real(data_2_real),
.Y_imag(data_2_imag),
.Wn_real(W0_real),
.Wn_imag(W0_imag),
.fft_a_real(fft_0_real),
.fft_a_imag(fft_0_imag),
.fft_b_real(fft_2_real),
.fft_b_imag(fft_2_imag)
);

butterfly_base a1(
.X_real(data_1_real),
.X_imag(data_1_imag),
.Y_real(data_3_real),
.Y_imag(data_3_imag),
.Wn_real(W4_real),
.Wn_imag(W4_imag),
.fft_a_real(fft_1_real),
.fft_a_imag(fft_1_imag),
.fft_b_real(fft_3_real),
.fft_b_imag(fft_3_imag)
);

endmodule
