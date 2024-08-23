//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_sequence.sv
// Developers   : 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_seq extends uvm_sequence #(alu_seq_item);

  // Factory registration
  `uvm_object_utils (alu_seq)

  // Class constructor
  function new (string name = "alu_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      txn = alu_seq_item::type_id::create("txn");
      wait_for_grant ();
      mainSeq: assert (txn.randomize)
      else $error ("%m Randomization failed!");
      send_request (txn);
      wait_for_item_done ();
    end
  endtask: body

endclass: alu_seq

//------------------------------------------------------------------------------
// Class       : arithmetic_ops_seq
// Description : Only arithmetic operations
//------------------------------------------------------------------------------

class arithmetic_ops_seq extends alu_seq;
  
  // Factory registration
  `uvm_object_utils (arithmetic_ops_seq)

  // Class constructor
  function new (string name = "arithmetic_ops_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      `uvm_do_with (txn, {txn.mode == 0});
    end
  endtask: body

endclass: arithmetic_ops_seq

//------------------------------------------------------------------------------
// Class       : logical_ops_seq
// Description : Only logical operations
//------------------------------------------------------------------------------

class logical_ops_seq extends alu_seq;
  
  // Factory registration
  `uvm_object_utils (logical_ops_seq)

  // Class constructor
  function new (string name = "logical_ops_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      `uvm_do_with (txn, {txn.mode == 1});
    end
  endtask: body

endclass: logical_ops_seq

//------------------------------------------------------------------------------
// Class       : set_cout_seq
// Description : Test for cout flag
//------------------------------------------------------------------------------

class set_cout_seq extends alu_seq;
  
  // Factory registration
  `uvm_object_utils (set_cout_seq)

  // Class constructor
  function new (string name = "set_cout_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      `uvm_do_with (txn, { txn.opa  == `DATA_WIDTH - 1; 
                           txn.opb  == 1'b1;
                           txn.mode == 1'b0;
                           txn.cmd  == 4'b0;
                         });
    end
  endtask: body

endclass: set_cout_seq

//------------------------------------------------------------------------------
// Class       : set_oflow_seq
// Description : Test for oflow flag
//------------------------------------------------------------------------------

class set_oflow_seq extends alu_seq;
  
  // Factory registration
  `uvm_object_utils (set_oflow_seq)

  // Class constructor
  function new (string name = "set_oflow_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      `uvm_do_with (txn, { txn.opa  == `DATA_WIDTH - 1; 
                           txn.opb  == `DATA_WIDTH - 1;
                           txn.mode == 1'b0;
                           txn.cmd  == 4'b0;
                         });
    end
  endtask: body

endclass: set_oflow_seq
