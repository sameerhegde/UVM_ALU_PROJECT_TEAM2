//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_agent_passive.sv
// Developers   : 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_agent_passive extends uvm_agent;
 
 'uvm_component_utils(alu_agent_active)
  function new(string name="alu_agent_passive",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  alu_monitor_read mon_r;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_PASSIVE) begin
      m1=alu_monitor_read::type_id::create("mon_r",this);
    end 
  endfunction

endclass


