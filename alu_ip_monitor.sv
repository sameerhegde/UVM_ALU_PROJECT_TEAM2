//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_ip_monitor.sv
// Developers   :Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//-----------------------------------------------------------------------------

`define IP_IF vif.MON.mon_cb
 
class alu_ip_monitor extends uvm_monitor;
  `uvm_component_utils(alu_ip_monitor)

   virtual alu_if vif;
   alu_seq_item ip_mon_h;

   uvm_analysis_port #(alu_seq_item) item_collected_port;
 
  function new (string name="alu_ip_monitor", uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   ip_mon_h = alu_seq_item::type_id::create("ip_mon_h");
    if(!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction
 

  virtual task run_phase(uvm_phase phase);
    forever 
       begin
         @(posedge vif.clk)
           begin
              ip_mon_h.ce =`IP_IF.ce;
              ip_mon_h.mode =`IP_IF.mode;
              ip_mon_h.opa=`IP_IF.opa;
              ip_mon_h.opb=`IP_IF.opb;
              ip_mon_h.cin =`IP_IF.cin;
              ip_mon_h.cmd =`IP_IF.cmd;
              ip_mon_h.inp_valid =`IP_IF.inp_valid;
              item_collected_port.write(ip_mon_h);
           end
        end 
  endtask
 
endclass


