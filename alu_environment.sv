//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_environment.sv
// Developers   : Raksha Nayak 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------


`include "macros.svh"
 import uvm_pkg::*;

`include "alu_agent_active.sv"
`include "alu_agent_passive.sv"
`include "alu_scoreboard.sv"
`inlcude "alu_coverage.sv"


class alu_env extends uvm_env;

  `uvm_component_utils(alu_env)

  function new(string name = "alu_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  alu_agt_active act_agent;
  alu_agt_passive pass_agent;
  alu_scb sbh;
  alu_cov cov;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    act_agent = alu_agt_active::type_id::create("act_agent", this);
    pass_agent = alu_agt_passive::type_id::create("pass_agent", this);
    sbh = alu_scb::type_id::create("sbh", this);
    cov =alu_cov::type_id::create("cov",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    act_agent.mon_w.item_collected_port.connect(sbh.ap_mon_wr);
    act_agent.mon_w.item_collected_port.connect(cov.item_collected_export);
    pass_agent.mon_r.item_collected_port.connect(sbh.ap_mon_rd);
    pass_agent.mon_r.item_collected_port.connect(cov.item_collected_export); 
  endfunction

endclass: alu_env

