//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_sequence_item.sv
// Developers   : Raksha Nayak
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_seq_item extends uvm_sequence_item;


  rand bit [`WIDTH - 1:0]opa;
  rand bit [`WIDTH - 1:0]opb;
  rand bit  ce;
  rand bit mode;
  rand bit cin;
  rand bit [1:0]inp_valid;
  rand bit [`CMD_WIDTH-1:0]cmd;
  bit [`WIDTH:0] res;
  bit  oflow,cout,g,l,e,err;

`uvm_object_utils_begin(alu_seq_item)
`uvm_field_int(opa,UVM_DEFAULT)
`uvm_field_int(opb,UVM_DEFAULT)
`uvm_field_int(ce,UVM_DEFAULT)
`uvm_field_int(mode,UVM_DEFAULT)
`uvm_field_int(cin,UVM_DEFAULT)
`uvm_field_int(inp_valid,UVM_DEFAULT)
`uvm_field_int(cmd,UVM_DEFAULT)
`uvm_object_utils_end

function new(string name ="alu_seq_item");
super.new(name);
endfunction

endclass
