
module STI(
input clk,
input rst,
input load,
input pi_fill,
input pi_msb,
input pi_low,
input [1:0]pi_length,
input [15:0]pi_data,
input pi_end,
output so_valid,
output reg so_data
);
reg [1:0]nstate;
reg [1:0]state;
reg [31:0]data;
reg [4:0]counter;

wire enable;
parameter idle=2'b00,load_data=2'b01,busy=2'b10,finish=2'b11;

assign enable=(state==busy);
assign so_valid=(state==busy)|(state==finish);




always@(posedge clk,posedge rst)
begin
	if(rst)
	state<=idle;
	else
	state<=nstate;
end

always@(*)
begin
	case(state)
	idle:begin
			if(load)
			nstate=load_data;
			else if(pi_end)
			nstate=finish;
			else
			nstate=idle;
		  end
	load_data:nstate=busy;
	busy:begin
			if(counter==5'd0)
			nstate=idle;
			else
			nstate=busy;
		  end
	finish:nstate=finish;
	default:nstate=idle;
	endcase
end






always @(posedge clk,posedge rst)
begin
	if(rst)
		data<=32'd0;
	else if(load)
		begin
			case(pi_length)
			2'b00:data<={16'd0,pi_data};
			2'b01:data<={16'd0,pi_data};
			2'b10:
					if(pi_fill)
					data<={pi_data,8'd0};
					else
					data<={16'd0,pi_data};
			2'b11:
					if(pi_fill)
					data<={pi_data,16'd0};
					else
					data<={16'd0,pi_data};
			endcase
		end
	 else if(enable)
		begin
				if(pi_msb)
				data<=data<<1'b1;
				else
				data<=data>>1'b1;
		end
	 
end

always @(posedge clk,posedge rst)
begin
	if(rst)
		counter<=5'd0;
	else if(load)
		begin
			case(pi_length)
			2'b00:counter<=5'd7;
			2'b01:counter<=5'd15;
			2'b10:counter<=5'd23;
			2'b11:counter<=5'd31;
			endcase
		end
	else if(enable)
		counter<=counter-5'd1;
end

always@(*)
begin
	case(pi_length)
	2'b00:begin
			if(pi_msb)
				begin
				if(pi_low)
				so_data=data[15];
				else
				so_data=data[7];
				end
			else
				begin
				if(pi_low)
				so_data=data[8];
				else
				so_data=data[0];
				end
			end
	2'b01:begin
			if(pi_msb)
				so_data=data[15];
			else
				so_data=data[0];
			end
	2'b10:begin
			if(pi_msb)
				so_data=data[23];
			else
				so_data=data[0];
			end
	2'b11:begin
			if(pi_msb)
				so_data=data[31];
			else
				so_data=data[0];
			end
	endcase
end

endmodule


