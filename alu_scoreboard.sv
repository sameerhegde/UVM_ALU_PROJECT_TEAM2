//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_scoreboard.sv
// Developers   : Vinod (5289)
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
  uvm_tlm_fifo #(alu_seq_item) wr_txn_fifo
  uvm_tlm_fifo #(alu_seq_item) rd_txn_fifo
  //alu_seq_item wr_txn_queue[$];
  //alu_seq_item rd_txn_queue[$];

  // Virtual interface handle
  virtual alu_if vif;

  // Count variable for compare status and total tests ran
  int pass, fail, total;

  // Build phase
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    ap_mon_wr = new ("ap_mon_wr", this);
    ap_mon_rd = new ("ap_mon_rd", this);
    wr_txn_fifo = new ("wr_txn_fifo", this);
    rd_txn_fifo = new ("rd_txn_fifo", this);
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
        case (txn.cmd)
          0: begin
            if (txn.inp_valid == 2'b11)
              txn.res = txn.opa + txn.opb;
            else
              txn.res = 'bz;
          end
          1: begin
            if (txn.inp_valid == 2'b11)
              txn.res = txn.opa - txn.opb;
            else
              txn.res = 'bz;
          end
          2: begin
            if (txn.inp_valid == 2'b11)
              txn.res = txn.opa + txn.opb + txn.cin;
            else
              txn.res = 'bz;
          end
          3: begin
            if (txn.inp_valid == 2'b11)
              txn.res = txn.opa - txn.opb - txn.cin;
            else
              txn.res = 'bz;
          end
          4: begin
            if (txn.inp_valid == 2'b01)
              txn.res = txn.opa + 1'b1;
            else
              txn.res = 'bz;
          end
          5: begin
            if (txn.inp_valid == 2'b01)
              txn.res = txn.opa - 1'b1;
            else
              txn.res = 'bz;
          end
          6: begin
            if (txn.inp_valid == 2'b10)
              txn.res = txn.opb + 1'b1;
            else
              txn.res = 'bz;
          end
          7: begin
            if (txn.inp_valid == 2'b10)
              txn.res = txn.opb - 1'b1;
            else
              txn.res = 'bz;
          end
          8: begin
            if (txn.inp_valid == 2'b11) begin
              if (txn.opa > txn.opb)  begin
                txn.g = 'b1; txn.l = 'b0; txn.e = 'b0;
              end
              else if (txn.opa < txn.opb) begin
                txn.g = 'b0; txn.l = 'b1; txn.e = 'b0;
              end
              else begin
                txn.g = 'b0; txn.l = 'b0; txn.e = 'b1;
              end
            end
          end
          9: begin
             if (txn.inp_valid == 2'b11)
               txn.res = (txn.opa + 1'b1) * (txn.opb + 1'b1);
             else
               txn.res = 'bz;
          end
          10: begin
            if (txn.inp_valid == 2'b11)
              txn.res = (txn.opa << 1) * txn.opb;
            else
              txn.res = 'bz;
          end
          default: txn.res = 'bz;
        endcase        
      end
      else begin
        case(txn.cmd)
           0: AND
             begin
               if(txn.inp_valid == 2'b11)
                  txn.res = txn.opa && txn.opb;
               else
                  txn.res = 'bz;
             end
           1: NAND
             begin
                if(txn.inp_valid == 2'b11)
                  txn.res = !(txn.opa && txn.opb);
               else
                  txn.res = 'bz;
             end
           2: OR
             begin
                if(txn.inp_valid == 2'b11)
                  txn.res = txn.opa || txn.opb;
               else
                  txn.res = 'bz;
             end
           3: NOR
             begin
                if(txn.inp_valid == 2'b11)
                  txn.res = !(txn.opa || txn.opb);
               else
                  txn.res = 'bz;
             end
           4: XOR
             begin
                if(txn.inp_valid == 2'b11)
                  txn.res = txn.opa ^ txn.opb;
               else
                  txn.res = 'bz;
             end
           5: XNOR
             begin
                if(txn.inp_valid == 2'b11)
                  txn.res = !(txn.opa ^ txn.opb);
               else
                  txn.res = 'bz;
             end


      end
    end
    wr_txn_fifo.try_put (txn);
  endfunction: write_mon_wr
  
  // Do something with the monitor_read txn
  virtual function void write_mon_rd (alu_seq_item txn);
    rd_txn_fifo.try_put (txn);
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
