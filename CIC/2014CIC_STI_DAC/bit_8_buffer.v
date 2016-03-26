module bit_8_buffer(
input clk,
input rst,
input enable,
input data_in,

output[7:0] data_out,
output reg valid
);
reg [7:0] data;
reg [2:0] count;

assign data_out=data;

always@(posedge clk)
begin
	if(rst)
	data<=8'd0;
	else if(enable)
	data<={data[6:0],data_in};
end

always@(posedge clk)
begin
	if(rst)
	count<=3'd0;
	else if(enable)
	count<=count+3'd1;
end

always@(posedge clk)
begin
	if(rst)
	valid<=0;
	else 
	valid<=(count==3'd7);
end
endmodule




module bit_8_reg(
input clk,
input rst,
input enable,
input [7:0]data_in,

output[7:0] data_out
);
reg [7:0] data;

assign data_out=data;

always@(posedge clk)
begin
	if(rst)
	data<=8'd0;
	else if(enable)
	data<=data_in;
end

endmodule