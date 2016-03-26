module butterfly_2_point(
input [31:0]data_0_real,
input [31:0]data_0_imag,
input [31:0]data_1_real,
input [31:0]data_1_imag,

output [31:0]fft_0_real,
output [31:0]fft_0_imag,
output [31:0]fft_1_real,
output [31:0]fft_1_imag
);

parameter W0_real=32'h00010000;
parameter W0_imag=32'h00000000;

butterfly_base a1(
.X_real(data_0_real),
.X_imag(data_0_imag),
.Y_real(data_1_real),
.Y_imag(data_1_imag),
.Wn_real(W0_real),
.Wn_imag(W0_imag),
.fft_a_real(fft_0_real),
.fft_a_imag(fft_0_imag),
.fft_b_real(fft_1_real),
.fft_b_imag(fft_1_imag)
);

endmodule
