//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_interface.sv
// Developers   : Team-2 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

interface alu_if (input bit clk, input bit rst);
  
  logic ce;
  logic cin;
  logic mode;
  logic [1:0] inp_valid;
  logic [`CMD_WIDTH - 1:0] cmd;
  logic [`DATA_WIDTH - 1:0] opa;
  logic [`DATA_WIDTH - 1:0] opb;
  
  logic [`DATA_WIDTH:0] res;
  logic oflow; 
  logic cout; 
  logic g; 
  logic l; 
  logic e; 
  logic err;
  
  clocking drv_cb @(posedge clk or posedge rst);
    default input #0 output #0;
    input rst;
    inout opa;
    inout opb; 
    inout ce; 
    inout mode; 
    inout cin; 
    inout inp_valid; 
    inout cmd;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #0 output #0;
    input res;
    input oflow; 
    input cout; 
    input g; 
    input l; 
    input e; 
    input err;
    input ce;
    input opa;
    input opb;  
    input mode; 
    input cin; 
    input inp_valid; 
    input cmd;
  endclocking
  
  modport DRV (clocking drv_cb);
  modport MON (clocking mon_cb);
    
endinterface
