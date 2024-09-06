//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_agent_active.sv
// Developers   : Team -2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_agent_active extends uvm_agent;
 
 `uvm_component_utils(alu_agent_active)

  function new(string name="alu_agent_active",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  alu_drv drv;
  alu_ip_monitor mon_ip;
  alu_seqr sqr_h;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ip = alu_ip_monitor::type_id::create("mon_ip", this);

    if(get_is_active()== UVM_ACTIVE) begin
      sqr_h = alu_seqr::type_id::create("sqr_h", this);
     drv = alu_drv::type_id::create("drv", this);  
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqr_h.seq_item_export);
 endfunction

endclass:alu_agent_active
