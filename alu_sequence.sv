//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_sequence.sv
// Developers   : Vinod (5289)
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
      `uvm_info("SEQUENCE","start",UVM_LOW)
      txn = alu_seq_item::type_id::create("txn");
      wait_for_grant ();
      assert (txn.randomize())
        $info("assertion passed");
      else 
        $error ("%m Randomization failed!");
      send_request (txn);
      wait_for_item_done ();
    end
  endtask: body

endclass: alu_seq

//------------------------------------------------------------------------------
// Description : Only arithmetic operations
//------------------------------------------------------------------------------

class alu_add_sequence extends alu_seq;

  `uvm_object_utils(alu_add_sequence)

  function new(string name = "alu_add_sequence");
    super.new(name);
  endfunction

  virtual task body();
  repeat (10) begin
    `uvm_do_with(txn, {
      txn.mode == 1'b1;
      txn.cmd ==4'b0000;txn.inp_valid == 2'b11; txn.ce == 1;
    })
    `uvm_info(get_type_name(),"hello",UVM_LOW)
   end
  endtask
endclass


// class alu_sub_sequence extends alu_seq;

//   `uvm_object_utils(alu_sub_sequence)

//   function new(string name = "alu_sub_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b0001;
//     })
//   endtask
// endclass

// class alu_add_cin_sequence extends alu_seq;

//   `uvm_object_utils(alu_add_cin_sequence)

//   function new(string name = "alu_add_cin_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b0010;
//     })
//   endtask
// endclass

// class alu_sub_cin_sequence extends alu_seq;

//   `uvm_object_utils(alu_sub_cin_sequence)

//   function new(string name = "alu_sub_cin_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b0011;
//     })
//   endtask
// endclass



// class alu_inc_op1_sequence extends alu_seq;

//   `uvm_object_utils(alu_inc_op1_sequence)

//   function new(string name = "alu_inc_op1_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b0100;
//     })
//   endtask
// endclass

// class alu_dec_op1_sequence extends alu_seq;

//   `uvm_object_utils(alu_dec_op1_sequence)

//   function new(string name = "alu_dec_op1_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b0101;
//     })
//   endtask
// endclass


// class alu_inc_op2_sequence extends alu_seq;

//   `uvm_object_utils(alu_inc_op2_sequence)

//   function new(string name = "alu_inc_op2_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b0110;
//     })
//   endtask
// endclass


// class alu_dec_op2_sequence extends alu_seq;

//   `uvm_object_utils(alu_dec_op2_sequence)

//   function new(string name = "alu_dec_op2_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b0111;
//     })
//   endtask
// endclass


// class alu_cmp_sequence extends alu_seq;

//   `uvm_object_utils(alu_cmp_sequence)

//   function new(string name = "alu_cmp_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd == 4'b1000;
//     })
//   endtask
// endclass


// class alu_inc_mul_sequence extends alu_seq;

//   `uvm_object_utils(alu_inc_mul_sequence)

//   function new(string name = "alu_inc_mul_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b1001;
//     })
//   endtask
// endclass

// class alu_opa_lshift_mul_op1_sequence extends alu_seq;

//   `uvm_object_utils(alu_opa_lshift_mul_sequence)

//   function new(string name = "alu_opa_lshift_mul_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b1;
//       txn.cmd ==4'b1010;
//     })
//   endtask
// endclass

// //------------------------------------------------------------------------------
// // Class       : logical_ops_seq
// // Description : Only logical operations
// //------------------------------------------------------------------------------

// class logical_ops_seq extends alu_seq;
  
//   // Factory registration
//   `uvm_object_utils (logical_ops_seq)

//   // Class constructor
//   function new (string name = "logical_ops_seq");
//     super.new (name);
//   endfunction: new

//   // Handle for alu_seq_item
//   alu_seq_item txn;

//   virtual task body;
//     repeat (`NUM_TRANSACTIONS) begin
//       `uvm_do_with (txn, {txn.mode == 0;});
//     end
//   endtask: body

// endclass: logical_ops_seq


// class alu_and_sequence extends alu_seq;

//   `uvm_object_utils(alu_and_sequence)

//   function new(string name = "alu_and_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b0000;
//     })
//   endtask
// endclass

// class alu_nand_sequence extends alu_seq;

//   `uvm_object_utils(alu_nand_sequence)

//   function new(string name = "alu_nand_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b0001;
//     })
//   endtask
// endclass

// class alu_or_sequence extends alu_seq;

//   `uvm_object_utils(alu_or_sequence)

//   function new(string name = "alu_or_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b0010;
//     })
//   endtask
// endclass

// class alu_nor_sequence extends alu_seq;

//   `uvm_object_utils(alu_nor_sequence)

//   function new(string name = "alu_nor_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b0011;
//     })
//   endtask
// endclass
// class alu_xor_sequence extends alu_seq;

//   `uvm_object_utils(alu_xor_sequence)

//   function new(string name = "alu_xor_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b0100;
//     })
//   endtask
// endclass

// class alu_xnor_sequence extends alu_seq;

//   `uvm_object_utils(alu_xnor_sequence)

//   function new(string name = "alu_xnor_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b0101;
//     })
//   endtask
// endclass

// class alu_not_op1_sequence extends alu_seq;

//   `uvm_object_utils(alu_not_op1_sequence)

//   function new(string name = "alu_not_op1_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b0110;
//     })
//   endtask
// endclass

// class alu_not_op2_sequence extends alu_seq;

//   `uvm_object_utils(alu_not_op2_sequence)

//   function new(string name = "alu_not_op2_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b0111;
//     })
//   endtask
// endclass

// class alu_shr1_op1_sequence extends alu_seq;

//   `uvm_object_utils(alu_shr1_op1_sequence)

//   function new(string name = "alu_shr1_op1_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b1000;
//     })
//   endtask
// endclass

// class alu_shl1_op1_sequence extends alu_seq;

//   `uvm_object_utils(alu_shl1_op1_sequence)

//   function new(string name = "alu_shl1_op1_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b1001;
//     })
//   endtask
// endclass

// class alu_shr1_op2_sequence extends alu_seq;

//   `uvm_object_utils(alu_shr1_op2_sequence)

//   function new(string name = "alu_shr1_op2_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b1010;
//     })
//   endtask
// endclass

// class alu_shl1_op2_sequence extends alu_seq;

//   `uvm_object_utils(alu_shl1_op2_sequence)

//   function new(string name = "alu_shl1_op2_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b1011;
//     })
//   endtask
// endclass

// class alu_ror_op1_op2_sequence extends alu_seq;

//   `uvm_object_utils(alu_ror_op1_op2_sequence)

//   function new(string name = "alu_ror_op1_op2_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b1100;
//     })
//   endtask
// endclass

// class alu_rol_op1_op2_sequence extends alu_seq;

//   `uvm_object_utils(alu_rol_op1_op2_sequence)

//   function new(string name = "alu_rol_op1_op2_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     `uvm_do_with(txn, {
//       txn.mode == 1'b0;
//       txn.cmd ==4'b1101;
//     })
//   endtask
// endclass

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
                           txn.mode == 1'b1;
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
                           txn.mode == 1'b1;
                           txn.cmd  == 4'b0;
                         });
    end
  endtask: body

endclass: set_oflow_seq

//------------------------------------------------------------------------------
// Class       : set_g_seq
// Description : Test for g flag
//------------------------------------------------------------------------------

class set_g_seq extends alu_seq;
  
  // Factory registration
  `uvm_object_utils (set_g_seq)

  // Class constructor
  function new (string name = "set_g_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      `uvm_do_with (txn, { txn.cmd  == 4'b1000;
                           txn.opa  > txn.opb;
                           txn.mode == 1'b0;
                         });
    end
  endtask: body

endclass: set_g_seq

//------------------------------------------------------------------------------
// Class       : set_l_seq
// Description : Test for l flag
//------------------------------------------------------------------------------

class set_l_seq extends alu_seq;
  
  // Factory registration
  `uvm_object_utils (set_l_seq)

  // Class constructor
  function new (string name = "set_l_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      `uvm_do_with (txn, { txn.cmd  == 4'b1000;
                           txn.opa  < txn.opb;
                           txn.mode == 1'b0;
                         });
    end
  endtask: body

endclass: set_l_seq

//------------------------------------------------------------------------------
// Class       : set_e_seq
// Description : Test for e flag
//------------------------------------------------------------------------------

class set_e_seq extends alu_seq;
  
  // Factory registration
  `uvm_object_utils (set_e_seq)

  // Class constructor
  function new (string name = "set_e_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      `uvm_do_with (txn, { txn.opa  == txn.opb; 
                           txn.cmd  == 4'b1000;
                           txn.mode == 1'b0;
                         });
    end
  endtask: body

endclass: set_e_seq

//------------------------------------------------------------------------------
// Class       : set_err_seq
// Description : Test for err flag
//------------------------------------------------------------------------------

class set_err_seq extends alu_seq;
  
  // Factory registration
  `uvm_object_utils (set_err_seq)

  // Class constructor
  function new (string name = "set_err_seq");
    super.new (name);
  endfunction: new

  // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body;
    repeat (`NUM_TRANSACTIONS) begin
      `uvm_do_with (txn, { txn.mode == 1'b0;
                           txn.cmd inside {[12: 13]};
                           txn.opb > 4'b1111;
                         });
    end
  endtask: body

endclass: set_err_seq
