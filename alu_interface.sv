//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_interface.sv
// Developers   : Team-2 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

//`include "alu_define.svh"

interface alu_if (input bit clk, input bit rst);
  
  logic ce;
  logic cin;
  logic mode;
  logic [1: 0] inp_valid;
  logic [`CMD_WIDTH - 1:  0] cmd;
  logic [`DATA_WIDTH - 1: 0] opa;
  logic [`DATA_WIDTH - 1: 0] opb;
  
  logic [`DATA_WIDTH : 0] res;
  logic oflow, cout, g, l, e, err;
  
  clocking drv_cb @(posedge clk or posedge rst);
    default input #0 output #0;
    inout opa, opb, ce, mode, cin, inp_valid, cmd;
    input rst;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #0 output #0;
    input res, oflow, cout, g, l, e, err;
  endclocking
  
  /*clocking ref_cb @ (posedge clk or posedge rst);
    default input #0 output #0;
    input rst;
  endclocking*/
  
  modport DRV (clocking drv_cb);
  modport MON (clocking mon_cb);

  //modport REF (clocking ref_cb);
    
endinterface
