
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
    repeat(10)begin
    seq_add.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_add


class alu_sub extends alu_test;
  `uvm_component_utils(alu_sub)
 
  alu_sub_sequence seq_sub;
 
  function new (string name = "alu_sub", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_sub = alu_sub_sequence::type_id::create("seq_sub");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_sub.start(env.act_h.sqr_h);
    end
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
   repeat(`NUM_TRANSACTIONS) begin
    seq_add_cin.start(env.act_h.sqr_h);
    end
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
    repeat(`NUM_TRANSACTIONS) begin
    seq_sub_cin.start(env.act_h.sqr_h);
    end
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
    repeat(`NUM_TRANSACTIONS) begin
    inc_opa.start(env.act_h.sqr_h);
    end
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
      repeat(`NUM_TRANSACTIONS) begin
    dec_opa.start(env.act_h.sqr_h);
       end
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
     repeat(`NUM_TRANSACTIONS) begin
    inc_opb.start(env.act_h.sqr_h);
       end
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
   repeat(`NUM_TRANSACTIONS) begin
    dec_opb.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_dec_opb

class alu_cmp extends alu_test;
  `uvm_component_utils(alu_cmp)
 
  alu_cmp_seq cmp_h;
 
  function new (string name = "alu_cmp", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    cmp_h = alu_cmp_seq::type_id::create("cmp_h");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
   repeat(`NUM_TRANSACTIONS) begin
    cmp_h.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_cmp

class alu_inc_mul extends alu_test;
  `uvm_component_utils(alu_inc_mul)
 
  alu_inc_mul_seq inc_mul_h;
 
  function new (string name = "alu_inc_mul", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    inc_mul_h = alu_inc_mul_seq::type_id::create("inc_mul_h");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
  repeat(`NUM_TRANSACTIONS) begin
    inc_mul_h.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_inc_mul

class alu_lshift_mul extends alu_test;
  `uvm_component_utils(alu_lshift_mul)
 
  alu_opa_lshift_mul_seq lshift_mul_h;
 
  function new (string name = "alu_lshift_mul", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    lshift_mul_h = alu_opa_lshift_mul_seq::type_id::create("lshift_mul_h");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    lshift_mul_h.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_lshift_mul

class alu_and extends alu_test;
  `uvm_component_utils(alu_and)
  alu_and_seq seq_and;
  function new (string name = "alu_and", uvm_component parent);
    super.new (name, parent);
  endfunction: new
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_and = alu_and_seq::type_id::create("seq_and");
  endfunction: build_phase
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
   repeat(`NUM_TRANSACTIONS) begin
    seq_and.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
endclass: alu_and

class alu_nand extends alu_test;
  `uvm_component_utils(alu_nand)
 
  alu_nand_seq seq_nand;
 
  function new (string name = "alu_nand", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_nand = alu_nand_seq::type_id::create("seq_nand");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
   repeat(`NUM_TRANSACTIONS) begin
    seq_nand.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_nand

class alu_or extends alu_test;
  `uvm_component_utils(alu_or)
 
  alu_or_seq seq_or;
 
  function new (string name = "alu_or", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_or = alu_or_seq::type_id::create("seq_or");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
   repeat(`NUM_TRANSACTIONS) begin
    seq_or.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_or



class alu_nor extends alu_test;
  `uvm_component_utils(alu_nor)
 
  alu_nor_seq seq_nor;
 
  function new (string name = "alu_nor", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_nor = alu_nor_seq::type_id::create("seq_nor");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_nor.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_nor



class alu_xor extends alu_test;
  `uvm_component_utils(alu_xor)
 
  alu_xor_seq seq_xor;
 
  function new (string name = "alu_xor", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_xor = alu_xor_seq::type_id::create("seq_xor");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
   repeat(`NUM_TRANSACTIONS) begin
    seq_xor.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_xor



class alu_xnor extends alu_test;
  `uvm_component_utils(alu_xnor)
 
  alu_xnor_seq seq_xnor;
 
  function new (string name = "alu_xnor", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_xnor = alu_xnor_seq::type_id::create("seq_xnor");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_xnor.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_xnor

class alu_not_opa extends alu_test;
  `uvm_component_utils(alu_not_opa)
 
  alu_not_opa_seq seq_not_opa;
 
  function new (string name = "alu_not_opa", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_not_opa = alu_not_opa_seq::type_id::create("seq_not_opa");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_not_opa.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_not_opa

 class alu_not_opb extends alu_test;
   `uvm_component_utils(alu_not_opb)
 
  alu_not_opb_seq seq_not_opb;
 
 
  function new (string name = "alu_not_opb", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_not_opb = alu_not_opb_seq::type_id::create("seq_not_opb");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_not_opb.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_not_opb



class alu_shr1_opa extends alu_test;
  `uvm_component_utils(alu_shr1_opa)
 
  alu_shr1_opa_seq seq_shr1_opa;
 
  function new (string name = "alu_shr1_opa", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_shr1_opa = alu_shr1_opa_seq::type_id::create("seq_shr1_opa");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_shr1_opa.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_shr1_opa


class alu_shl1_opa extends alu_test;
  `uvm_component_utils(alu_shl1_opa)
 
  alu_shl1_opa_seq seq_shl1_opa;
 
  function new (string name = "alu_shl1_opa", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_shl1_opa = alu_shl1_opa_seq::type_id::create("seq_shl1_opa");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_shl1_opa.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_shl1_opa

class alu_shr1_opb extends alu_test;
  `uvm_component_utils(alu_shr1_opb)
 
  alu_shr1_opb_seq seq_shr1_opb;
 
  function new (string name = "alu_shr1_opb", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_shr1_opb = alu_shr1_opb_seq::type_id::create("seq_shr1_opb");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_shr1_opb.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_shr1_opb

 class alu_shl1_opb extends alu_test;
     `uvm_component_utils(alu_shl1_opb)
 
  alu_shl1_opb_seq seq_shl1_opb;
 
     function new (string name = "alu_shl1_opb", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
       seq_shl1_opb = alu_shl1_opb_seq::type_id::create("seq_shl1_opb");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_shl1_opb.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_shl1_opb



class alu_ror_opa_opb extends alu_test;
  `uvm_component_utils(alu_ror_opa_opb)
 
  alu_ror_opa_opb_seq seq_ror_opa_opb;
 
  function new (string name = "alu_ror_opa_opb", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_ror_opa_opb = alu_ror_opa_opb_seq::type_id::create("seq_ror_opa_opb");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_ror_opa_opb.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_ror_opa_opb


class alu_rol_opa_opb extends alu_test;
  `uvm_component_utils(alu_rol_opa_opb)
 
  alu_rol_opa_opb_seq seq_rol_opa_opb;
 
  function new (string name = "alu_rol_opa_opb", uvm_component parent);
    super.new (name, parent);
  endfunction: new
 
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_rol_opa_opb = alu_rol_opa_opb_seq::type_id::create("seq_rol_opa_opb");
  endfunction: build_phase
 
  virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    repeat(`NUM_TRANSACTIONS) begin
    seq_rol_opa_opb.start(env.act_h.sqr_h);
    end
    phase.drop_objection (this);
  endtask: run_phase
 
endclass: alu_rol_opa_opb

class alu_regression extends alu_test;
  `uvm_component_utils(alu_regression)
  alu_add_sequence seq_add;
  alu_sub_sequence seq_sub;
  alu_add_cin_seq  seq_add_cin;
  alu_sub_cin_seq  seq_sub_cin;
  alu_inc_opa_seq  seq_inc_opa;
  alu_dec_opa_seq  seq_dec_opa;
  alu_inc_opb_seq  seq_inc_opb;
  alu_dec_opb_seq  seq_dec_opb;
  alu_cmp_seq      seq_cmp;
  alu_inc_mul_seq  seq_inc_mul;
  alu_opa_lshift_mul_seq  seq_opa_lshift_mul;
  alu_and_seq      seq_and;
  alu_nand_seq     seq_nand;
  alu_or_seq       seq_or;
  alu_nor_seq      seq_nor;
  alu_xor_seq      seq_xor;
  alu_xnor_seq     seq_xnor;
  alu_not_opa_seq  seq_not_opa;
  alu_not_opb_seq  seq_not_opb;
  alu_shr1_opa_seq  seq_shr1_opa;
  alu_shl1_opa_seq  seq_shl1_opa;
  alu_shr1_opb_seq  seq_shr1_opb;
  alu_shl1_opb_seq  seq_shl1_opb;
  alu_ror_opa_opb_seq seq_ror;
  alu_rol_opa_opb_seq seq_rol;
  function new (string name = "alu_regression", uvm_component parent);
    super.new (name, parent);
  endfunction: new
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq_add = alu_add_sequence::type_id::create("seq_add");
    seq_sub = alu_sub_sequence::type_id::create("seq_sub");
    seq_add_cin = alu_add_cin_seq::type_id::create("seq_add_cin");
    seq_sub_cin = alu_sub_cin_seq::type_id::create("seq_sub_cin");
    seq_inc_opa = alu_inc_opa_seq::type_id::create("seq_inc_opa");
    seq_dec_opa = alu_dec_opa_seq::type_id::create("seq_dec_opa");
    seq_inc_opb = alu_inc_opb_seq::type_id::create("seq_inc_opb");
    seq_dec_opb = alu_dec_opb_seq::type_id::create("seq_dec_opb");
    seq_cmp = alu_cmp_seq::type_id::create("seq_cmp");
    seq_inc_mul = alu_inc_mul_seq::type_id::create("seq_inc_mul");
    seq_opa_lshift_mul = alu_opa_lshift_mul_seq::type_id::create("seq_opa_lshift_mul");
    seq_and = alu_and_seq::type_id::create("seq_and");
    seq_nand = alu_nand_seq::type_id::create("seq_nand");
    seq_or = alu_or_seq::type_id::create("seq_or");
    seq_nor = alu_nor_seq::type_id::create("seq_nor");
    seq_xor = alu_xor_seq::type_id::create("seq_xor");
    seq_xnor = alu_xnor_seq::type_id::create("seq_xnor");
    seq_not_opa = alu_not_opa_seq::type_id::create("seq_not_opa");
    seq_not_opb = alu_not_opb_seq::type_id::create("seq_not_opb");
    seq_shr1_opa = alu_shr1_opa_seq::type_id::create("seq_shr1_opa");
    seq_shl1_opa = alu_shl1_opa_seq::type_id::create("seq_shl1_opa");
    seq_shr1_opb = alu_shr1_opb_seq::type_id::create("seq_shr1_opb");
    seq_shl1_opb = alu_shl1_opb_seq::type_id::create("seq_shl1_opb");
    seq_ror = alu_ror_opa_opb_seq::type_id::create("seq_ror");
    seq_rol = alu_rol_opa_opb_seq::type_id::create("seq_rol");
  endfunction: build_phase
   virtual function void end_of_elaboration ();
    print ();
  endfunction: end_of_elaboration
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq_add.start(env.act_h.sqr_h);
    #20;
    seq_sub.start(env.act_h.sqr_h);
    #20;
    seq_add_cin.start(env.act_h.sqr_h);
    #20;
    seq_sub_cin.start(env.act_h.sqr_h);
    #20;
    seq_inc_opa.start(env.act_h.sqr_h);
    #20;
    seq_dec_opa.start(env.act_h.sqr_h);
    #20;
    seq_inc_opb.start(env.act_h.sqr_h);
    #20;
    seq_dec_opb.start(env.act_h.sqr_h);
    #20;
    seq_cmp.start(env.act_h.sqr_h);
    #20;
    seq_inc_mul.start(env.act_h.sqr_h);
    #20;
    seq_opa_lshift_mul.start(env.act_h.sqr_h);
    #20;
    seq_and.start(env.act_h.sqr_h);
    #20;
    seq_nand.start(env.act_h.sqr_h);
    #20;
    seq_or.start(env.act_h.sqr_h);
    #20;
    seq_nor.start(env.act_h.sqr_h);
    #20;
    seq_xor.start(env.act_h.sqr_h);
    #20;
    seq_xnor.start(env.act_h.sqr_h);
    #20;
    seq_not_opa.start(env.act_h.sqr_h);
    #20;
    seq_not_opb.start(env.act_h.sqr_h);
    #20;
    seq_shr1_opa.start(env.act_h.sqr_h);
	#20;
    seq_shl1_opa.start(env.act_h.sqr_h);
   	#20;
    seq_shr1_opb.start(env.act_h.sqr_h);
    #20;
    seq_shl1_opb.start(env.act_h.sqr_h);
	#20;
    seq_ror.start(env.act_h.sqr_h);
    #20;
    seq_rol.start(env.act_h.sqr_h);
    phase.drop_objection (this);
  endtask: run_phase
endclass
