//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_agent_active.sv
// Developers   : 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

`include "macros.svh"
 import uvm_pkg::*;

`include "alu_driver.sv"
`include "alu_monitor.sv"
`include "alu_sequencer.sv"


class alu_agent_active extends uvm_agent;
 
 `uvm_component_utils(alu_agent_active)
  function new(string name="alu_agent_active",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  alu_driver dr;
  alu_monitor_write mon_w;
  alu_seqr sq;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active()== UVM_ACTIVE) begin
      sq = alu_seqr::type_id::create("sq", this);
      dr = alu_driver::type_id::create("dr", this);
      mon_w = alu_monitor_write::type_id::create("mon_w", this);
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    dr.seq_item_port.connect(sq.seq_item_export);
  endfunction

endclass
