//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_sequence_item.sv
// Developers   : Raksha Nayak
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

/*import uvm_pkg::*;
`include "uvm_macros.svh"
`include "alu_define.svh"*/

class alu_seq_item extends uvm_sequence_item;

  rand bit ce;
  rand bit cin;
  rand bit mode;
  rand bit [1: 0] inp_valid;
  rand bit [`CMD_WIDTH - 1:  0] cmd;
  rand bit [`DATA_WIDTH - 1: 0] opa;
  rand bit [`DATA_WIDTH - 1: 0] opb;

  bit [`DATA_WIDTH: 0] res;
  bit oflow, cout, g, l, e, err;

  rand int unsigned delay;

  `uvm_object_utils_begin (alu_seq_item)
    `uvm_field_int (ce,        UVM_DEFAULT)
    `uvm_field_int (cin,       UVM_DEFAULT)
    `uvm_field_int (cmd,       UVM_DEFAULT)
    `uvm_field_int (opa,       UVM_DEFAULT)
    `uvm_field_int (opb,       UVM_DEFAULT)
    `uvm_field_int (mode,      UVM_DEFAULT)
    `uvm_field_int (inp_valid, UVM_DEFAULT)

    `uvm_field_int (delay, UVM_DEFAULT)

  `uvm_object_utils_end

  function new (string name = "alu_seq_item");
    super.new(name);
  endfunction

  constraint c1_mode
  {
    if( mode==0) cmd inside {[0: 13]};
    else cmd inside {[0: 10]};               
  }
  constraint c2_inp_valid 
  {
    inp_valid dist {0:=5, 1:=10, 2:=10, 3:=10};                     
  }
  constraint c3_cmd 
  { 
    cmd dist {[0: 13]:=1};                
  }
  constraint c4_delay
  { 
     solve delay before opa;
     solve delay before opb;
     delay inside {[0: 16]};                
  }

endclass: alu_seq_item
