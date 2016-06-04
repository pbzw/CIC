module bit_8_buffer(
input clk,
input rst,
input enable,
input data_in,

output[7:0] data_out,
output  valid
);
reg [7:0] data;
reg [3:0] count;

assign data_out={data[6:0],data_in};

always@(posedge clk,posedge rst)
begin
	if(rst)
	data<=8'd0;
	else if(enable)
	data<={data[6:0],data_in};
end

always@(posedge clk,posedge rst)
begin
	if(rst)
	count<=4'd0;
	else if(enable)
	count<=(count==4'd8)?4'd1:count+4'd1;
	else
	count<=4'd0;
end


assign	valid=(count==4'd8);


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

always@(posedge clk,posedge rst)
begin
	if(rst)
	data<=8'd0;
	else if(enable)
	data<=data_in;
end

endmodule