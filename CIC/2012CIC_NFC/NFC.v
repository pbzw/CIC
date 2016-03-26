`timescale 1ns/100ps
module NFC(clk, rst, done, F_IO_A, F_CLE_A, F_ALE_A, F_REN_A, F_WEN_A, F_RB_A, F_IO_B, F_CLE_B, F_ALE_B, F_REN_B, F_WEN_B, F_RB_B);

  input clk;
  input rst;
  output done;
  inout [7:0] F_IO_A;
  output F_CLE_A;
  output F_ALE_A;
  output F_REN_A;
  output F_WEN_A;
  input  F_RB_A;
  inout [7:0] F_IO_B;
  output F_CLE_B;
  output F_ALE_B;
  output F_REN_B;
  output F_WEN_B;
  input  F_RB_B;
  
  wire allmost_full,data_get,allmost_empty;
  wire read_data_valid,empty,busy;
  wire [7:0]read_data;
  wire [7:0]write_data;
  
Nnad_flash_reader a(
 .clk(clk),
 .rst(rst),
 .F_IO_A(F_IO_A),
 .F_CLE_A(F_CLE_A),
 .F_ALE_A(F_ALE_A),
 .F_REN_A(F_REN_A),
 .F_WEN_A(F_WEN_A),
 .F_RB_A(F_RB_A),
 .valid(read_data_valid),
 .data(read_data),
 .wait_(allmost_full)
 );
 
FIFO FIFO_1(
.clk(clk),
.rst(rst),
.put(read_data_valid),
.get(data_get),
.put_data(read_data),

.full(),
.empty(empty),
.allmost_full(allmost_full),
.allmost_empty(allmost_empty),
.get_data(write_data)

);
 
 Nnad_flash_writer b(
 .clk(clk),
 .rst(rst),
 .en(!empty),
 .F_IO_B(F_IO_B),
 .F_CLE_B(F_CLE_B),
 .F_ALE_B(F_ALE_B),
 .F_REN_B(F_REN_B),
 .F_WEN_B(F_WEN_B),
 .F_RB_B(F_RB_B),
 .data_get(data_get),
 .data(write_data),
 .done(done)
 );
 
 
  endmodule
