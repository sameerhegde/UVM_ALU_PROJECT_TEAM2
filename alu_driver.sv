//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_driver.sv
// Developers   : Vinod (5289)
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_drv extends uvm_driver #(alu_seq_item);

  // Factory registration
  `uvm_component_utils (alu_drv);

  // New function
  function new (string name = "alu_drv", uvm_component parent);
    super.new (name, parent);
  endfunction: new

  // Virtual interface handle
  virtual alu_if.drv_mp vif; 

  // Sequence item handle
  alu_seq_item txn; 
  
  // Build phase
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    // Get the virtuaal interface from the factory
    if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal ("No vif", {"Set virtual interface to: ", get_full_name (), ".vif"});
  endfunction: build_phase

  // Run task
  virtual task run_phase ();
    repeat (`NUM_TRANSACTIONS) begin
      seq_item_port.get_next_item (txn);
      driver ();
      seq_item_port.item_done ();
    end
  endtask: run_phase

  // drive task...
  task driver ();
    @(posedge vif.clk);
    if (vif.rst) begin
      vif.ce = 'bz;
      vif.cin = 'bz;
      vif.cmd = 'bz;
      vif.opa = 'bz;
      vif.opb = 'bz;
      vif.mode = 'bz;
      vif.inp_valid = 'bz;
      @(posedge vif.clk)
    end
    else begin
      vif.ce = txn.ce;
      vif.cin = txn.cin;
      vif.cmd = txn.cmd;
      vif.opa = txn.opa;
      vif.opb = txn.opb;
      vif.mode = txn.mode;
      vif.inp_valid = txn.inp_valid;
      @(posedge vif.clk)
    end
  endtask: driver

endclass: alu_drv
