//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_scoreboard.sv
// Developers   : 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

`uvm_analysis_imp_decl (_mon_wr)
`uvm_analysis_imp_decl (_mon_rd)

class alu_scb extends uvm_scoreboard;
  
  // Factory registration
  `uvm_component_utils (alu_scb)

  // Class constructor
  function new (string name = "alu_scb", uvm_component parent);
    super.new (name);
  endfunction: new

  // Analysis implemenatation ports
  uvm_analysis_imp_mon_wr #(alu_seq_item, alu_scb) ap_mon_wr;
  uvm_analysis_imp_mon_rd #(alu_seq_item, alu_scb) ap_mon_rd;

  // FIFOs
  // uvm_tlm_fifo #(alu_seq_item) wr_txn_fifo
  // uvm_tlm_fifo #(alu_seq_item) rd_txn_fifo
  alu_seq_item wr_txn_queue[$];
  alu_seq_item rd_txn_queue[$];

  // Build phase
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    ap_mon_wr = new ("ap_mon_wr", this);
    ap_mon_rd = new ("ap_mon_rd", this);
  endfunction: build_phase
  
  virtual function void write_mon_wr (alu_seq_item txn);
    // wr_txn_queue;
  endfunction: write_mon_wr
  
  virtual function void write_mon_rd (alu_seq_item txn);
    // rd_txn_queue
  endfunction: write_mon_rd

  virtual task run_phase (uvm_phase phase);

  endtask: run_phase

endclass: alu_scb
