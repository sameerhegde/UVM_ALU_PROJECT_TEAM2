//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_agent_active.sv
// Developers   : Nisha
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_agent_active extends uvm_agent;
 
 'uvm_component_utils(alu_agent_active)
  function new(string name="alu_agent_active",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  alu_driver d0;
  alu_monitor_write m0;
  alu_sequencer s0;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active()== UVM_ACTIVE) begin
      s0 = alu_sequencer::type_id::create("s0", this);
      d0 = alu_driver::type_id::create("d0", this);
      m0 = alu_monitor_write::type_id::create("m0", this);
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
  endfunction

endclass
