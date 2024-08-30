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

  // Virtual interface handle
  virtual alu_if vif;

  // Count variable for compare status and total tests ran
  int pass, fail, total;

  // Build phase
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    ap_mon_wr = new ("ap_mon_wr", this);
    ap_mon_rd = new ("ap_mon_rd", this);
  endfunction: build_phase
 
  // Do something with the monitor_write txn
  virtual function void write_mon_wr (alu_seq_item txn);
    if (vif.rst || txn.ce == 0) begin
      txn.res = 'bz;
      txn.cout = 'bz;
      txn.oflow = 'bz;
      txn.g = 'bz;
      txn.l = 'bz;
      txn.e = 'bz;
      txn.err = 'bz;
    end
    else if (txn.ce == 1) begin
      if (txn.mode == 1) begin
        // arithmetic checkers...
      end
      else begin
        // logical checkers...
      end
    end
    wr_txn_queue.try_put (txn);
  endfunction: write_mon_wr
  
  // Do something with the monitor_read txn
  virtual function void write_mon_rd (alu_seq_item txn);
    rd_txn_queue.try_put (txn);
  endfunction: write_mon_rd

  // Run phase
  virtual task run_phase (uvm_phase phase);
    alu_seq_item act_txn;
    alu_seq_item exp_txn;
    repeat (`NUM_TRANSACTIONS) begin
      wr_txn_queue.get (exp_txn);
      rd_txn_queue.get (act_txn);
      // Compare

      // Call test_pass(), test_fail() functions
    end
  endtask: run_phase

  // Test has compared
  function void test_pass;
    pass++;
    total++;
  endfunction: test_pass

  // Test has failed
  function void test_fail;
    fail++;
    total++;
  endfunction: test_fail

endclass: alu_scb
