module DAC(
input clk,
input rst,
input so_data,
input so_valid,

output [7:0] oem_dataout,
output [4:0]oem_addr,
output  odd1_wr,
output  odd2_wr,
output  odd3_wr,
output  odd4_wr,
output  even1_wr,
output  even2_wr,
output  even3_wr,
output  even4_wr,
output  oem_finish
);
parameter idle=4'b0000,load=4'b0001,write=4'b0011,wait_=4'b0111,finish=4'b1111;
wire [9:0]data_count;
wire [7:0]data;
wire [6:0]out_addr;
wire data_valid,odd,even;
wire [3:0]select;
reg [3:0]state;
reg [3:0]next;

assign oem_addr=data_count[5:1];
assign oem_finish=(state==finish);


bit_8_buffer bit_8_buffer(
.clk(clk),
.rst(rst),
.enable(so_valid),
.data_in(so_data),
.data_out(data),
.valid(data_valid)
);


always@(posedge clk,posedge rst)
begin
	if(rst)
	state<=idle;
	else
	state<=next;
end

always@(*)
begin
	case(state)
	idle:begin
			if(data_valid)
			next=load;
			else if((data_count[8:0]==9'd256))
			next=finish;
			else
			next=idle;
		  end
	load:next=write;
	write:next=wait_;
	wait_:next=idle;
	finish:next=finish;
	endcase
end

odd_even odd_even(
.clk(clk),
.rst(rst),
.enable((state==write)),
.even(even),
.odd(odd)
);

up_counter #(.WIDTH(10))addr_counter(
.clk(clk),
.rst(rst),
.en((state==wait_)),
.clr(1'b0),
.count(data_count)
);

buffer #(.WIDTH(8))data_buffer(
.clk(clk),
.rst(rst),
.en(data_valid),
.clr(1'b0),
.data_in(data),
.data_out(oem_dataout)
);

decoder decoder(
.in(data_count[7:6]),
.out(select)
);

edge_signal odd1(
.clk(clk),
.rst(rst),
.enable((select[0]&(state==load)&odd)),
.signal(odd1_wr)
);

edge_signal odd2(
.clk(clk),
.rst(rst),
.enable((select[1]&(state==load)&odd)),
.signal(odd2_wr)
);

edge_signal odd3(
.clk(clk),
.rst(rst),
.enable((select[2]&(state==load)&odd)),
.signal(odd3_wr)
);

edge_signal odd4(
.clk(clk),
.rst(rst),
.enable((select[3]&(state==load)&odd)),
.signal(odd4_wr)
);

edge_signal even1(
.clk(clk),
.rst(rst),
.enable((select[0]&(state==load)&even)),
.signal(even1_wr)
);


edge_signal even2(
.clk(clk),
.rst(rst),
.enable((select[1]&(state==load)&even)),
.signal(even2_wr)
);


edge_signal even3(
.clk(clk),
.rst(rst),
.enable((select[2]&(state==load)&even)),
.signal(even3_wr)
);


edge_signal even4(
.clk(clk),
.rst(rst),
.enable((select[3]&(state==load)&even)),
.signal(even4_wr)
);


endmodule

module edge_signal(
input clk,
input rst,
input enable,
output reg signal
);

always@(posedge clk,posedge rst)
begin
	if(rst)
	signal=1'b0;
	else if(enable)
	signal=1'b1;
	else
	signal=1'b0;
end

endmodule

module odd_even(
input clk,
input rst,
input enable,
output even,
output odd
);
reg [15:0]oe;

assign odd=(oe[15]==1);
assign even=(oe[15]==0);

always@(posedge clk,posedge rst)
begin
	if(rst)
	oe<=16'b1010101001010101;
	else if(enable)
	oe<={oe[14:0],oe[15]};
end

endmodule


