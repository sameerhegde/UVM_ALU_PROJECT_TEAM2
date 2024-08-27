//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_monitor_read.sv
// Developers   : Raksha Nayak
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------




`define MON_IF vif.MON.mon_cb

class alu_mon extends uvm_monitor;

  virtual alu_if vif;

  uvm_analysis_port #(alu_seq_item) item_collected_port;

  alu_seq_item alu_seq_item_1;

  `uvm_component_utils(alu_mon)

  function new (string name="alu_mon", uvm_component parent);
    super.new(name, parent);
    alu_seq_item_1 = new();
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual rs_interface)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.MON.clk);
      //wait(MON_IF.ce);
      if(MON_IF.ce) begin
        alu_seq_item_1.cout = MON_IF.cout;
        alu_seq_item_1.oflow=MON_IF.oflow;
        alu_seq_item_1.res=MON_IF.res;
        alu_seq_item_1.err=MON_IF.err;
        alu_seq_item_1.g=MON_IF.g;
        alu_seq_item_1.l=MON_IF.l;
        alu_seq_item_1.e=MON_IF.e;
      end
    //  item_collected_port.write(alu_seq_item_1);
    end 
  endtask

endclass

