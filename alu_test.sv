//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_test.sv
// Developers   : Vinod (5289)
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_test extends uvm_test;

  // Factory registration
  `uvm_component_utils (alu_test)

  // Environment class handle
  alu_env env;

  // Base sequence handle
  alu_seq seq;

  // New function
  function new (string name = "alu_test", uvm_component parent);
    super.new (name, parent);
  endfunction: new

  // Build phase
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    env = alu_env::type_id::create("env", this);
  endfunction: build_phase

  // End of elaboration phase
  virtual function end_of_elaboration (uvm_phase phase);
    // Print topology
    print ():
  endfunction: end_of_elaboration

  // Run phase;
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq = alu_seq::type_id::create("seq");
    phase.drop_objection (this);
  endtask: run_phase

endclass: alu_test

//------------------------------------------------------------------------------
// Class         : arithmetic_ops_test
// Description   : Test only arithmetic functionality
//------------------------------------------------------------------------------

class arithmetic_ops_test extends alu_test;
  
  // Factory registration
  `uvm_component_utils (arithmetic_ops_test)

  // Environment class handle
  alu_env env_a;

  // Base sequence handle
  arithemtic_ops_seq seq;

  // New function
  function new (string name = "arithemtic_ops_test", uvm_component parent);
    super.new (name, parent);
  endfunction: new

  // Build phase
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    env_a = alu_env::type_id::create("env_a", this);
  endfunction: build_phase

  // End of elaboration phase
  virtual function end_of_elaboration (uvm_phase phase);
    // Print topology
    print ():
  endfunction: end_of_elaboration

  // Run phase;
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq = arithmetic_ops_seq::type_id::create("seq");
    phase.drop_objection (this);
  endtask: run_phase

endclass: arithmetic_ops_test

//------------------------------------------------------------------------------
// Class         : logical_ops_test
// Description   : Test only arithmetic functionality
//------------------------------------------------------------------------------

class logical_ops_test extends alu_test;
  
  // Factory registration
  `uvm_component_utils (logical_ops_test)

  // Environment class handle
  alu_env env_l;

  // Base sequence handle
  arithemtic_ops_seq seq;

  // New function
  function new (string name = "logical_ops_test", uvm_component parent);
    super.new (name, parent);
  endfunction: new

  // Build phase
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    env_l = alu_env::type_id::create("env_l", this);
  endfunction: build_phase

  // End of elaboration phase
  virtual function end_of_elaboration (uvm_phase phase);
    // Print topology
    print ():
  endfunction: end_of_elaboration

  // Run phase;
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq = arithmetic_ops_seq::type_id::create("seq");
    phase.drop_objection (this);
  endtask: run_phase

endclass: logical_ops_test

