//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_monitor_write.sv
// Developers   :Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//-----------------------------------------------------------------------------

`include "alu_driver.sv"

`define WR_IF vif.mon_mp
 
class alu_monitor_write extends uvm_monitor;
  `uvm_component_utils(alu_monitor_write)

   virtual alu_if vif;
   alu_seq_item write_h;

   uvm_analysis_port #(alu_seq_item) item_collected_port;
 
  function new (string name="alu_monitor_write", uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   write_h = alu_seq_item::type_id::create("write_h");
    if(!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction
 

  virtual task run_phase(uvm_phase phase);
    forever 
       begin
         @(posedge vif.MON.clk)
           begin
              write_h.ce =`WR_IF.ce;
              write_h.mode =`WR_IF.mode;
              write_h.opa=`WR_IF.opa;
              write_h.opb=`WR_IF.opb;
              write_h.cin =`WR_IF.cin;
              write_h.cmd =`WR_IF.cmd;
              write_h.inp_valid =`WR_IF.inp_valid;
        
              item_collect_port.write(write_h);
           end
        end 
  endtask
 
endclass

