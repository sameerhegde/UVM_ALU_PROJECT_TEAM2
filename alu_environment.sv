//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_environment.sv
// Developers   : Raksha Nayak 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------


`include "alu_agt_active.sv"
`include "alu_agt_passive.sv"
`include "alu_scb.sv"

class alu_env extends uvm_environment;
  alu_agt_active alu_agt_active_1;
  alu_agt_passive alu_agt_passive_1;
  alu_scb alu_scb_1;
  
  `uvm_component_utils(alu_env)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    alu_agt_active_1 = alu_agt_active::type_id::create("alu_agt_active_1", this);
    alu_agt_passive_1 =alu_agt_passive::type_id::create("alu_agt_passive_1",this);
    alu_scb_1 = alu_scb::type_id::create("alu_acb_1", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    alu_agt_active_1.alu_mon_wr_1.item_collected_port.connect(alu_scb_1.item_collected_export);
    alu_agt_passive_1.alu_mon_rd_1.item_collected_port.connect(alu_scb_1.item_collected_export);
  endfunction

endclass
