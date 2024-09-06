//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_environment.sv
// Developers   : Team-2 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------


class alu_env extends uvm_env;

  `uvm_component_utils(alu_env)

  function new(string name = "alu_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  alu_agent_active act_h;
  alu_agent_passive pass_h;
  alu_scb scb_h;
  //alu_cov cov_h;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   act_h = alu_agent_active::type_id::create("act_h", this);
   pass_h = alu_agent_passive::type_id::create("pass_h", this);
   scb_h = alu_scb::type_id::create("scb_h", this);
   //cov_h =alu_cov::type_id::create("cov_h",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    act_h.mon_ip.item_collected_port.connect(scb_h.ip_mon_port);
    //act_h.mon_ip.item_collected_port.connect(cov_h.mon_ip_imp);
    pass_h.mon_op.item_collected_port.connect(scb_h.op_mon_port);
    //pass_h.mon_op.item_collected_port.connect(cov_h.mon_op_imp); 
  endfunction

endclass: alu_env
