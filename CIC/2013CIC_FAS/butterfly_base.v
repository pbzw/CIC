module butterfly_base(
input [31:0]X_real,
input [31:0]X_imag,
input [31:0]Y_real,
input [31:0]Y_imag,
input [31:0]Wn_real,
input [31:0]Wn_imag,
output [31:0]fft_a_real,
output [31:0]fft_a_imag,
output [31:0]fft_b_real,
output [31:0]fft_b_imag
);
wire [31:0]asc,dsb,bsd;
wire [47:0]Wn_real_extend,Wn_imag_extend,fft_b_real_MA,fft_b_iamg_MA,asc_extend,dsb_extend,bsd_extend,ascxWn_real,dsbxWn_imag;
//X_real=a,Y_real=c
//X_imag=b,Y_imag=d
assign fft_a_real=X_real+Y_real;
assign fft_a_imag=X_imag+Y_imag;
assign asc=(X_real-Y_real);//a sub c
assign dsb=(Y_imag-X_imag);//d sub b
assign bsd=(X_imag-Y_imag);//b sub d
//need to extend 48bit
assign asc_extend=asc[31]?{16'hffff,asc}:{16'h0000,asc};//a sub c
assign dsb_extend=dsb[31]?{16'hffff,dsb}:{16'h0000,dsb};//d sub b
assign bsd_extend=bsd[31]?{16'hffff,bsd}:{16'h0000,bsd};//b sub d

assign Wn_real_extend=Wn_real[31]?{16'hffff,Wn_real}:{16'h00,Wn_real};
assign Wn_imag_extend=Wn_imag[31]?{16'hffff,Wn_imag}:{16'h00,Wn_imag};

assign ascxWn_real=asc_extend*Wn_real_extend;
assign dsbxWn_imag=dsb_extend*Wn_imag_extend;

assign fft_b_real_MA=ascxWn_real+dsbxWn_imag;
assign fft_b_iamg_MA=asc_extend*Wn_imag_extend+bsd_extend*Wn_real_extend;

assign fft_b_real=fft_b_real_MA[47:16];
assign fft_b_imag=fft_b_iamg_MA[47:16];

endmodule

module butterfly_base_16bits(
input [15:0]X_real,
input [15:0]X_imag,
input [15:0]Y_real,
input [15:0]Y_imag,
input [31:0]Wn_real,
input [31:0]Wn_imag,
output [31:0]fft_a_real,
output [31:0]fft_a_imag,
output [31:0]fft_b_real,
output [31:0]fft_b_imag
);

wire [15:0]asc,dsb,bsd,aac,bad;
wire [47:0]Wn_real_extend,Wn_imag_extend,fft_b_real_MA,fft_b_iamg_MA,asc_extend,dsb_extend,bsd_extend,ascxWn_real,dsbxWn_imag;
//X_real=a,Y_real=c
//X_imag=b,Y_imag=d
assign aac=X_real+Y_real;
assign bad=X_imag+Y_imag;

assign fft_a_real=aac[15]?{8'hff,aac,8'h00}:{8'h000,aac,8'h00};
assign fft_a_imag=bad[15]?{8'hff,bad,8'h00}:{8'h000,bad,8'h00};

assign asc=(X_real-Y_real);//a sub c
assign dsb=(Y_imag-X_imag);//d sub b
assign bsd=(X_imag-Y_imag);//b sub d
//need to extend 48bit
assign asc_extend=asc[15]?{24'hffffff,asc,8'h00}:{24'h0000,asc,8'h00};//a sub c
assign dsb_extend=dsb[15]?{24'hffffff,dsb,8'h00}:{24'h0000,dsb,8'h00};//d sub b
assign bsd_extend=bsd[15]?{24'hffffff,bsd,8'h00}:{24'h0000,bsd,8'h00};//b sub d

assign Wn_real_extend=Wn_real[31]?{16'hffff,Wn_real}:{16'h00,Wn_real};
assign Wn_imag_extend=Wn_imag[31]?{16'hffff,Wn_imag}:{16'h00,Wn_imag};

assign ascxWn_real=asc_extend*Wn_real_extend;
assign dsbxWn_imag=dsb_extend*Wn_imag_extend;

assign fft_b_real_MA=ascxWn_real+dsbxWn_imag;
assign fft_b_iamg_MA=asc_extend*Wn_imag_extend+bsd_extend*Wn_real_extend;

assign fft_b_real=fft_b_real_MA[47:16];
assign fft_b_imag=fft_b_iamg_MA[47:16];

endmodule
