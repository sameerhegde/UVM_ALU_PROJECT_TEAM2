//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_monitor_read.sv
// Developers   : Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

`include "alu_sequence_item.sv"

`define RD_IF vif.MON.mon_cb

class alu_monitor_read extends uvm_monitor;

 `uvm_component_utils(alu_monitor_read)

  virtual alu_if vif;
  alu_seq_item read_h;

  uvm_analysis_port #(alu_seq_item) item_collected_port;

  function new (string name="alu_monitor_read", uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    read_h = alu_seq_item::type_id::create("read_h");
    if(!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever 
       begin
         @(posedge vif.clk)
           begin
             read_h.cout = RD_IF.cout;
             read_h.oflow = RD_IF.oflow;
             read_h.res = RD_IF.res;
             read_h.err = RD_IF.err;
             read_h.g = RD_IF.g;
             read_h.l = RD_IF.l;
             read_h.e = RD_IF.e;
             
             item_collected_port.write(read_h);
          end
    end 
  endtask

endclass

