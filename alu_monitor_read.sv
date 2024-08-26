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
        alu_seq_item_1.co = MON_IF.rd_en;
        alu_seq_item_1.wr_en = 0;
        @(posedge vif.MON.clk);
        @(posedge vif.MON.clk);
        alu_seq_item_1.rdata = MON_IF.rdata;
      end
      item_collected_portiiiiiiik.write(alu_sequence_item_1);
    end 
  endtask

endclass

