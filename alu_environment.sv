//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_environment.sv
// Developers   : Raksha Nayak 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_env extends uvm_environment;

  `uvm_component_utils(alu_env)

  function new(string name = "alu_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  alu_agt_active act_agent;
  alu_agt_passive pass_agent;
  alu_scb sbh;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    act_agent = alu_agt_active::type_id::create("act_agent", this);
    pass_agent = alu_agt_passive::type_id::create("pass_agent", this);
    sbh = alu_scb::type_id::create("sbh", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    alu_agt_active_1.alu_mon_wr_1.item_collected_port.connect(alu_scb_1.item_collected_export);
    alu_agt_passive_1.alu_mon_rd_1.item_collected_port.connect(alu_scb_1.item_collected_export);
    //
  endfunction

endclass: alu_env

