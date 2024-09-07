//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_test.sv
// Developers   : Team-2
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
  virtual function void end_of_elaboration ();
  // Print topology
    print ();
  endfunction: end_of_elaboration

  // Run phase;
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq = alu_seq::type_id::create("seq");
    phase.drop_objection (this);
  endtask: run_phase

endclass: alu_test

class alu_add extends alu_test;
  `uvm_component_utils(alu_add)
 
  alu_add_sequence seq_add;
 
  function new (string name = "alu_add", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_add = alu_add_sequence::type_id::create("seq_add");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq_add.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_add


class alu_sub extends alu_test;
  `uvm_component_utils(alu_sub)
 
  alu_sub_seq seq_sub;
 
  function new (string name = "alu_sub", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_sub = alu_sub_seq::type_id::create("seq_sub");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq_sub.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_sub

class alu_add_cin extends alu_test;
  `uvm_component_utils(alu_add_cin)
 
  alu_add_cin_seq seq_add_cin;
 
  function new (string name = "alu_add", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_add_cin = alu_add_cin_seq::type_id::create("seq_add_cin");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq_add_cin.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_add_cin

class alu_sub_cin extends alu_test;
  `uvm_component_utils(alu_sub_cin)
 
  alu_sub_cin_seq seq_sub_cin;
 
  function new (string name = "alu_sub_cin", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_sub_cin = alu_sub_cin_seq::type_id::create("seq_sub_cin");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq_sub_cin.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_sub_cin

class alu_inc_opa extends alu_test;
  `uvm_component_utils(alu_inc_opa)
 
  alu_inc_opa_seq inc_opa;
 
  function new (string name = "alu_inc_opa", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    inc_opa = alu_inc_opa_seq::type_id::create("inc_opa");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    inc_opa.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_inc_opa

class alu_dec_opa extends alu_test;
  `uvm_component_utils(alu_dec_opa)
 
  alu_dec_opa_seq dec_opa;
 
  function new (string name = "alu_dec_opa", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    dec_opa = alu_dec_opa_seq::type_id::create("dec_opa");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    dec_opa.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_dec_opa

class alu_inc_opb extends alu_test;
  `uvm_component_utils(alu_inc_opb)
 
  alu_inc_opb_seq inc_opb;
 
  function new (string name = "alu_inc_opb", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    inc_opb = alu_inc_opb_seq::type_id::create("inc_opb");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    inc_opb.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_inc_opb

class alu_dec_opb extends alu_test;
  `uvm_component_utils(alu_dec_opb)
 
  alu_dec_opb_seq dec_opb;
 
  function new (string name = "alu_dec_opb", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    dec_opb = alu_dec_opb_seq::type_id::create("dec_opb");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    dec_opb.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_dec_opb
