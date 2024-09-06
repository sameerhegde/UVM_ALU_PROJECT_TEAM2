//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_agent_passive.sv
// Developers   : Team -2 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_agent_passive extends uvm_agent;
 
 `uvm_component_utils(alu_agent_passive)
 
  function new(string name="alu_agent_passive",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  alu_op_monitor mon_op;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //if(get_is_active() == UVM_PASSIVE) begin
     mon_op=alu_op_monitor::type_id::create("mon_op",this);
  // end 
  endfunction

endclass

