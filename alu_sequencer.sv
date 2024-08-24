//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_sequencer.sv
// Developers   : Nisha Shetty
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_seqr extends uvm_sequencer #(alu_seq_item);

  `uvm_object_utils (alu_seqr)

  function new (string name = "alu_seqr");
    super.name (name);
  endfunction
  
endclass: alu_seqr
