 module Nnad_flash_writer(
 inout [7:0] F_IO_B,
  input clk,
  input rst,
  input  en,
  input  F_RB_B,
  input [7:0]data,
  
  output data_get,
  output F_CLE_B,
  output F_ALE_B,
  output F_REN_B,
  output F_WEN_B,
  
  output done

 );
 
 wire com_en,data_en,address_en_0,address_en_1,address_en_2;
 wire [23:0]address;
 wire [7:0]comand,write_data;
 
 
Nnad_flash_writer_state_machine fsaf(
.clk(clk),
.rst(rst), 
.en(en),
.F_CLE_B(F_CLE_B),
.F_ALE_B(F_ALE_B),
.F_REN_B(F_REN_B),
.F_WEN_B(F_WEN_B),
.F_RB_B(F_RB_B),
.com_en(com_en),
.data_en(data_en),
.data_get(data_get),
.address_en_0(address_en_0),
.address_en_1(address_en_1),
.address_en_2(address_en_2),
.address_count(address),
.cmd(comand),
.done(done)
 );
 tri_write_con a(
.data_to_nand(F_IO_B),
.com_en(com_en),
.com(comand),
.address_en_0(address_en_0),
.address_en_1(address_en_1),
.address_en_2(address_en_2),
.address(address),
.write_data(write_data),
.data_en(data_en)
);
 
 reg_8_bit bit_8(
.clk(clk),
.rst(rst),
.en(data_get),
.data_in(data),
.data(write_data),
.valid()
 );
 
 endmodule
 
 
 module tri_write_con(
  input com_en,
  input data_en,
  input address_en_0,
  input address_en_1,
  input address_en_2,
  input [23:0]address,
  input [7:0]com,
  input [7:0]write_data,
  inout [7:0]data_to_nand

 );

 assign data_to_nand=data_en?write_data:8'bzzzzzzzz;
 assign data_to_nand=com_en?com:8'bzzzzzzzz;
 assign data_to_nand=address_en_0?address[7:  0]:8'bzzzzzzzz;
 assign data_to_nand=address_en_1?address[16: 9]:8'bzzzzzzzz;
 assign data_to_nand=address_en_2?{7'b0,address[17]}:8'bzzzzzzzz;
 
 endmodule