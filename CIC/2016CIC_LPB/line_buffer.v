//line_buffer 瘛勗漲 64 撖
module line_buffer(
input clk,
input rst,
input en,
input [7:0]data_in,
output reg[7:0]data_out,
output reg valid
);
integer i;
 
reg [7:0]mem[0:127];
reg valid_mem[0:127];
wire [6:0]write_counter_count;
wire [6:0]read_counter_count=write_counter_count+7'b1;


always@(posedge clk,posedge rst)
begin
	if(rst)
	begin
		data_out=8'b0;
		valid=1'b0;
	end
	else
	begin
	 data_out=mem[(read_counter_count)];
	 valid=valid_mem[(read_counter_count)];
	 end
end

up_counter #(.WIDTH (7)) write_counter(
.clk(clk),
.rst(rst),
.clr(1'b0),
.en(en),
.count(write_counter_count)
);




always @(posedge clk)
begin
	if(en)
	mem[write_counter_count]<=data_in;

end

always @(posedge clk,posedge rst)
begin
	if(rst)
	begin
		for(i=0;i<128;i=i+1)
		valid_mem[i]<=1'b0;
	end
	else
		valid_mem[write_counter_count]<=en;
end

endmodule