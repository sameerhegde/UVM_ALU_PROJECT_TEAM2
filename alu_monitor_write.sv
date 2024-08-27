//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_monitor_write.sv
// Developers   :nisha 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//-----------------------------------------------------------------------------
`define MON_IF vif.MON.mon_cb
 
class alu_monitor_write extends uvm_monitor;
 
  virtual alu_if vif;
 
  uvm_analysis_port #(alu_seq_item) item_collected_port;
 
  alu_seq_item alu_seq_item_1;
 
  `uvm_component_utils(alu_monitor_write)
 
  function new (string name="alu_monitor_write", uvm_component parent);
    super.new(name, parent);
    alu_seq_item_1 = new();
    item_collected_port = new("item_collected_port", this);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction
 

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.MONITOR.clk);;
      if(MON_IF.ce) begin
        //alu_seq_item_1.ce = MON_IF.ce;
        alu_seq_item_1.mode = MON_IF.mode;
        alu_seq_item_1.opa=MON_IF.opa;
        alu_seq_item_1.opb=MON_IF.opb;
        alu_seq_item_1.cin = MON_IF.cin;
        alu_seq_item_1.cmd = MON_IF.cmd;
        alu_seq_item_1.inp_valid =  MON_IF.inp_valid;
   
      end
  end 
  endtask
 
endclass

