//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_driver.sv
// Developers   : Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

`include "alu_sequence_item.sv"

class alu_drv extends uvm_driver #(alu_seq_item);

  `uvm_component_utils (alu_drv);

  function new (string name = "alu_drv", uvm_component parent);
    super.new (name, parent);
  endfunction: new

  virtual alu_if vif;  
  
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal ("No vif", {"Set virtual interface to: ", get_full_name (), ".vif"});
  endfunction: build_phase

  alu_seq_item txn;

  virtual task run_phase(uvm_phase phase);
    repeat (`NUM_TRANSACTIONS)
        begin
          @(posedge vif.clk)
          seq_item_port.get_next_item (txn);
          drive();
          seq_item_port.item_done ();
        end
  endtask: run_phase

  // drive task...
  task drive();
    if (vif.rst)
      begin
        vif.ce <= 'bz;
        vif.cin <= 'bz;
        vif.cmd <= 'bz;
        vif.opa <= 'bz;
        vif.opb <= 'bz;
        vif.mode <= 'bz;
        vif.inp_valid = 'bz;
      end
    else
      begin
       vif.ce <= txn.ce; 
       vif.cin <= txn.cin;
       vif.cmd <= txn.cmd;     
       vif.opa <= txn.opa;
       vif.opb <= txn.opb;
       vif.mode <= txn.mode;
       vif.inp_valid <= txn.inp_valid;
     end
  endtask
endclass: alu_drv
