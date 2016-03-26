module Serial_to_Parallel(
input clk,
input rst,
input fir_valid,
input [15:0]fir_data,

output reg valid,
output[15:0]data_out_0,
output[15:0]data_out_1,
output[15:0]data_out_2,
output[15:0]data_out_3,
output[15:0]data_out_4,
output[15:0]data_out_5,
output[15:0]data_out_6,
output[15:0]data_out_7,
output[15:0]data_out_8,
output[15:0]data_out_9,
output[15:0]data_out_10,
output[15:0]data_out_11,
output[15:0]data_out_12,
output[15:0]data_out_13,
output[15:0]data_out_14,
output[15:0]data_out_15
);
reg [3:0]count ;

reg [15:0]data[0:15];

wire[15:0] data_0;
wire[15:0] data_1;
wire[15:0] data_2;
wire[15:0] data_3;
wire[15:0] data_4;
wire[15:0] data_5;
wire[15:0] data_6;
wire[15:0] data_7;
wire[15:0] data_8;
wire[15:0] data_9;
wire[15:0] data_10;
wire[15:0] data_11;
wire[15:0] data_12;
wire[15:0] data_13;
wire[15:0] data_14;
wire[15:0] data_15;

assign data_out_0=data[0];
assign data_out_1=data[1];
assign data_out_2=data[2];
assign data_out_3=data[3];
assign data_out_4=data[4];
assign data_out_5=data[5];
assign data_out_6=data[6];
assign data_out_7=data[7];
assign data_out_8=data[8];
assign data_out_9=data[9];
assign data_out_10=data[10];
assign data_out_11=data[11];
assign data_out_12=data[12];
assign data_out_13=data[13];
assign data_out_14=data[14];
assign data_out_15=data[15];

always@(posedge clk)
begin
	if(rst)
	count<=4'd0;
	else	if(fir_valid)
	begin
	count<=count+4'd1;
	end
end

always@(posedge clk)
begin
data[count]<=fir_data;
end

always@(posedge clk)
begin
	if(rst)
	valid<=0;
	else	if(count==4'd15)
	valid<=1;
	else
	valid<=0;
	
end

endmodule
