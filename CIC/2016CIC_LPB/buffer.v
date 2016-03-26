module buffer #(parameter WIDTH = 32)(
input clk,
input rst,
input en,
input[WIDTH-1:0] data_in,
output reg[WIDTH-1:0] data_out,
output reg valid
);
parameter zero={(WIDTH){1'b0}};


always@(posedge clk,posedge rst)
begin
	if(rst)
	data_out<=zero;
	else
	begin	
		if(en)
		data_out<=data_in;
	end
end


always@(posedge clk,posedge rst)
begin
	if(rst)
	valid<=1'b0;
	else 
	valid<=en;
end

endmodule