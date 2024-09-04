//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_op_monitor.sv
// Developers   : Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

`include "alu_sequence_item.sv"

`define OP_IF vif.MON.mon_cb

class alu_op_monitor extends uvm_monitor;

 `uvm_component_utils(alu_op_monitor)

  virtual alu_if vif;
  alu_seq_item op_mon_h;

  uvm_analysis_port #(alu_seq_item) item_collected_port;

  function new (string name="alu_op_monitor", uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    op_mon_h = alu_seq_item::type_id::create("op_mon_h");
    if(!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever 
       begin
         @(posedge vif.clk)
           begin
             op_mon_h.cout = OP_IF.cout;
             op_mon_h.oflow = OP_IF.oflow;
             op_mon_h.res = OP_IF.res;
             op_mon_h.err = OP_IF.err;
             op_mon_h.g = OP_IF.g;
             op_mon_h.l = OP_IF.l;
             op_mon_h.e = OP_IF.e;
             
             item_collected_port.write(op_mon_h);
          end
    end 
  endtask

endclass

