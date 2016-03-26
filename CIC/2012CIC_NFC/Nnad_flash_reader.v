module Nnad_flash_reader(
  input clk,
  input rst,
  inout [7:0] F_IO_A,
  input wait_,
  
  output [7:0]data,
  output valid,
  output F_CLE_A,
  output F_ALE_A,
  output F_REN_A,
  output F_WEN_A,
  input  F_RB_A
 );
 
 wire com_en,address_en_0,address_en_1,address_en_2;
 wire [23:0]address;
 wire [7:0]comand;
Nnad_flash_reader_state_machine state(
.clk(clk),
.rst(rst),
.wait_(wait_), 
.F_CLE_A(F_CLE_A),
.F_ALE_A(F_ALE_A),
.F_REN_A(F_REN_A),
.F_WEN_A(F_WEN_A),
.F_RB_A(F_RB_A),
.com_en(com_en),
.data_en(data_valid),
.address_en_0(address_en_0),
.address_en_1(address_en_1),
.address_en_2(address_en_2),
.address_count(address)
 );
 tri_con a(
.data_to_nand(F_IO_A),
.com_en(com_en),
.address_en_0(address_en_0),
.address_en_1(address_en_1),
.address_en_2(address_en_2),
.address(address)
 );
 
 reg_8_bit bit_8(
.clk(clk),
.rst(rst),
.en(data_valid),
.data_in(F_IO_A),
.data(data),
.valid(valid)
 );
 
 endmodule
 
 
 module tri_con(
  input com_en,
  input address_en_0,
  input address_en_1,
  input address_en_2,
  input [23:0]address,
  
  inout [7:0]data_to_nand

 );

 
 assign data_to_nand=com_en?{7'b0,address[8]}:8'bzzzzzzzz;
 assign data_to_nand=address_en_0?address[7:  0]:8'bzzzzzzzz;
 assign data_to_nand=address_en_1?address[16: 9]:8'bzzzzzzzz;
 assign data_to_nand=address_en_2?{7'b0,address[17]}:8'bzzzzzzzz;
 
 endmodule
 
  module reg_8_bit(
  input clk,
  input rst,
  input en,
  input [7:0]data_in,
  output reg valid,
  output reg [7:0]data
 );
  always@(posedge clk,posedge rst)
 begin
	if(rst)
	data<=8'd0;
	else if(en)
	data<=data_in;
 end
   always@(posedge clk,posedge rst)
 begin
	if(rst)
	valid<=0;
	else 
	valid<=en;
 end
 endmodule
 