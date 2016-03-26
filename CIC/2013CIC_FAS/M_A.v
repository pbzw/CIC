module M_A(
input clk,
input rst,
input enable,
input [15:0]data_in,
input [19:0]coefficient,
output valid,
output [15:0]data_out,
output [31:0]mul_out
);

wire[31:0]sign_extend;
wire[31:0]mul;
wire [31:0]mul_extend,coefficient_extend;

DF data_reg(
.clk(clk),
.rst(rst),
.enable(enable),
.data_in(data_in),
.data_out(data_out),
.valid(valid)
);

assign sign_extend=data_in[15]?{16'hffff,data_in}:{16'h0,data_in};//符號對齊
assign coefficient_extend=coefficient[19]?{12'hfff,coefficient}:{12'h0,coefficient};
assign mul=sign_extend*coefficient_extend;
assign mul_out={mul[31:1],1'b1};

endmodule

module DF(
input clk,
input rst,
input enable,
input [15:0]data_in,

output valid,
output [15:0]data_out
);

reg [16:0]data;

always@(posedge clk) begin
if(rst)
data<=17'b0;
else
data<={enable,data_in};
end

assign {valid,data_out}=data;

endmodule
