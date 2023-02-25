// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat Feb 25 12:27:09 2023
// Host        : DESKTOP-CRQ4OKO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/Downloads/ad_da_hdmi-master/ad_da_vga/ad_da_vga.srcs/sources_1/ip/vio_0/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.2" *)
module vio_0(clk, probe_in0, probe_out0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[0:0],probe_out0[12:0]" */;
  input clk;
  input [0:0]probe_in0;
  output [12:0]probe_out0;
endmodule
