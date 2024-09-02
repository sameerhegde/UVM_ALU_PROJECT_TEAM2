//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_monitor_write.sv
// Developers   :Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//-----------------------------------------------------------------------------
`define MON_IF vif.mon_mp
 
class alu_monitor_write extends uvm_monitor;
 
  virtual alu_if vif;
 
 uvm_analysis_port #(alu_seq_item) item_collected_port;
 
  alu_seq_item write_h;
 
  `uvm_component_utils(alu_monitor_write)
 
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
         @(posedge vif.MON.clk);
           write_h.ce = `MON_IF.ce;
           write_h.mode = `MON_IF.mode;
           write_h.opa=`MON_IF.opa;
           write_h.opb=`MON_IF.opb;
           write_h.cin = `MON_IF.cin;
           write_h.cmd = `MON_IF.cmd;
           write_h.inp_valid =  `MON_IF.inp_valid;
        
           item_collect_port.write(write_h);
       end
  end 
  endtask
 
endclass

