//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_sequence.sv
// Developers   : Team-2
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
      `uvm_info("SEQUENCE","start",UVM_LOW)
      txn = alu_seq_item::type_id::create("txn");
      wait_for_grant ();
      txn.randomize();
      send_request (txn);
      wait_for_item_done ();
    //end
  endtask: body

endclass: alu_seq

//-----------------------------------------------------------------------------
// ARITHMETIC OPERATIONS
//-----------------------------------------------------------------------------

class alu_add_sequence extends uvm_sequence #(alu_seq_item);

  `uvm_object_utils(alu_add_sequence)

  function new(string name = "alu_add_sequence");
    super.new(name);
  endfunction
  
  alu_seq_item txn;

  virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
    txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0000; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
       txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0000;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0000;txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass


class alu_sub_sequence extends alu_seq;

  `uvm_object_utils(alu_sub_sequence)

  function new(string name = "alu_sub_sequence");
    super.new(name);
  endfunction
  
  alu_seq_item txn;

  virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
    txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0001; txn.delay < 8;txn.opa>txn.opb;};
    send_request(txn);
    wait_for_item_done();
   
    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0001;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize() with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0001;txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass
//-------------------------------------------------------------------------------------
class alu_add_cin_seq extends alu_seq;

  `uvm_object_utils(alu_add_cin_seq)

  function new(string name = "alu_add_cin_seq");
    super.new(name);
  endfunction

   
  alu_seq_item txn;

  virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
    txn.randomize()with {txn.mode == 1; txn.ce == 1;txn.cin == 1; txn.cmd == 4'b0010; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1;txn.cin == 1; txn.cmd == 4'b0010;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {txn.mode == 1; txn.ce == 1;txn.cin == 1; txn.cmd == 4'b0010;txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass
// -------------------------------------------------------------------------------------------------------
class alu_sub_cin_seq extends alu_seq;

  `uvm_object_utils(alu_sub_cin_seq)

  function new(string name = "alu_sub_cin_seq");
    super.new(name);
  endfunction
 
  alu_seq_item txn;

  virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
    txn.randomize()with {txn.mode == 1; txn.ce == 1;txn.cin == 1; txn.cmd == 4'b0011; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1;txn.cin == 1; txn.cmd == 4'b0011;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {txn.mode == 1; txn.ce == 1;txn.cin == 1; txn.cmd == 4'b0011;txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

// ---------------------------------------------------------------------------------------------------

class alu_inc_opa_seq extends alu_seq;

  `uvm_object_utils(alu_inc_opa_seq)

  function new(string name = "alu_inc_opa_seq");
    super.new(name);
  endfunction

 alu_seq_item txn;

  virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
    txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0100; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
    if(txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0100;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0100;txn.inp_valid==2'b01||txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
    endtask
endclass

//-------------------------------------------------------------------------------------------
class alu_dec_opa_seq extends alu_seq;

  `uvm_object_utils(alu_dec_opa_seq)

  function new(string name = "alu_dec_opa_seq");
    super.new(name);
  endfunction
  alu_seq_item txn;

 virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
   txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0101; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
    if(txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0101;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0101;txn.inp_valid==2'b01 || txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
    endtask
endclass
//--------------------------------------------------------------------------------------------------------
class alu_inc_opb_seq extends alu_seq;

  `uvm_object_utils(alu_inc_opb_seq)

  function new(string name = "alu_inc_opb_seq");
    super.new(name);
  endfunction
alu_seq_item txn;

 virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
   txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0110; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
   if(txn.inp_valid == 2'b01) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0110;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0110;txn.inp_valid==2'b10 || txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
    endtask
endclass

//-------------------------------------------------------------------------------------------------
class alu_dec_opb_seq extends alu_seq;

  `uvm_object_utils(alu_dec_opb_seq)

  function new(string name = "alu_dec_opb_seq");
    super.new(name);
  endfunction
alu_seq_item txn;

 virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
   txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0111; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
   if(txn.inp_valid == 2'b01) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0111;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
     txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b0111;txn.inp_valid==2'b10 || txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
    endtask
endclass
//-----------------------------------------------------------------------------------------
class alu_cmp_seq extends alu_seq;

  `uvm_object_utils(alu_cmp_seq)

  function new(string name = "alu_cmp_seq");
    super.new(name);
  endfunction
  alu_seq_item txn;
 virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
   txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1000; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
   if(txn.inp_valid == 2'b01 || txn.inp_valid ==2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1000;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
     txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1000; txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
    endtask
endclass

//---------------------------------------------------------------------------------------------------
class alu_inc_mul_seq extends alu_seq;

  `uvm_object_utils(alu_inc_mul_seq)

  function new(string name = "alu_inc_mul_seq");
    super.new(name);
  endfunction
  
 alu_seq_item txn;
  
 virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
   txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1001; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
   if(txn.inp_valid == 2'b01 || txn.inp_valid ==2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1001;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
     txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1001; txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
    endtask
endclass
//---------------------------------------------------------------------------------------------
class alu_opa_lshift_mul_seq extends alu_seq;

  `uvm_object_utils(alu_opa_lshift_mul_seq)

  function new(string name = "alu_opa_lshift_mul_seq");
    super.new(name);
  endfunction
  
 alu_seq_item txn;
  
  virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
    txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1010; txn.delay < 8;};
    send_request(txn);
    wait_for_item_done();
   
   if(txn.inp_valid == 2'b01 || txn.inp_valid ==2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1010;};
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
     txn.randomize()with {txn.mode == 1; txn.ce == 1; txn.cmd == 4'b1010; txn.inp_valid==2'b11;};
       send_request(txn);
       wait_for_item_done();
    end
    endtask
endclass


// //----------------------------------------------------------------------------------x	

// //------------------------------------------------------------------------------
// // Class       : logical_ops_seq
// // Description : Only logical operations
// //------------------------------------------------------------------------------

  

class alu_and_seq extends alu_seq;

  `uvm_object_utils(alu_and_seq)

  function new(string name = "alu_and_seq");
    super.new(name);
  endfunction

  virtual task body();

    alu_seq_item::type_id::create("txn");
    wait_for_grant();
        txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b0000;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b0000;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b0000;
        txn.inp_valid==2'b11;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_nand_seq extends alu_seq;

  `uvm_object_utils(alu_nand_seq)

  function new(string name = "alu_nand_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

 virtual task body();
     txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b0001;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b0001;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b0001;
        txn.inp_valid==2'b11;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_or_seq extends alu_seq;

  `uvm_object_utils(alu_or_seq)

  function new(string name = "alu_or_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body();
   txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b0010;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b0010;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b0010;
        txn.inp_valid==2'b11;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass
class alu_nor_seq extends alu_seq;

  `uvm_object_utils(alu_nor_seq)

  function new(string name = "alu_nor_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b0011;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b0011;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b0011;
        txn.inp_valid==2'b11;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_xor_seq extends alu_seq;

  `uvm_object_utils(alu_xor_seq)

  function new(string name = "alu_xor_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body();
   txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b0100;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b0100;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b0100;
        txn.inp_valid==2'b11;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_xnor_seq extends alu_seq;

  `uvm_object_utils(alu_xnor_seq)

  function new(string name = "alu_xnor_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

 virtual task body();
  txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b0101;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b0101;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b0101;
        txn.inp_valid==2'b11;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass
class alu_not_opa_seq extends alu_seq;

  `uvm_object_utils(alu_not_opa_seq)

  function new(string name = "alu_not_opa_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

    virtual task body();
      txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b0110;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if( txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b0110;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b0110;
        txn.inp_valid==2'b11 ||  txn.inp_valid==2'b01;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_not_opb_seq extends alu_seq;

  `uvm_object_utils(alu_not_opb_seq)

  function new(string name = "alu_not_opb_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

    virtual task body();
     txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b0111;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b0111;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b0111;
        txn.inp_valid==2'b11 || txn.inp_valid==2'b10;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_shr1_opa_seq extends alu_seq;

  `uvm_object_utils(alu_shr1_opa_seq)

  function new(string name = "alu_shr1_opa_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

   virtual task body();
   txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b1000;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b1000;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b1000;
        txn.inp_valid==2'b11 || txn.inp_valid==2'b01;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_shl1_opa_seq extends alu_seq;

  `uvm_object_utils(alu_shl1_opa_seq)

  function new(string name = "alu_shl1_opa_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body();
   txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b1001;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b10 ) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b1001;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b1001;
        txn.inp_valid==2'b11 || txn.inp_valid == 2'b01;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass
class alu_shr1_opb_seq extends alu_seq;

  `uvm_object_utils(alu_shr1_opb_seq)

  function new(string name = "alu_shr1_opb_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

   virtual task body();
     txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b1010;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 ) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b1010;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b1010;
        txn.inp_valid==2'b11 || txn.inp_valid == 2'b10;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_shl1_opb_seq extends alu_seq;

  `uvm_object_utils(alu_shl1_opb_seq)

  function new(string name = "alu_shl1_opb_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body();
    txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b1011;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 ) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b1011;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b1011;
        txn.inp_valid==2'b11 || txn.inp_valid == 2'b10;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_ror_opa_opb_seq extends alu_seq;

  `uvm_object_utils(alu_ror_opa_opb_seq)

  function new(string name = "alu_ror_opa_opb_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

  virtual task body();
     txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b1100;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b1100;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b1100;
        txn.inp_valid==2'b11;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass

class alu_rol_opa_opb_seq extends alu_seq;

  `uvm_object_utils(alu_rol_opa_opb_seq)

  function new(string name = "alu_rol_opa_opb_seq");
    super.new(name);
  endfunction

   // Handle for alu_seq_item
  alu_seq_item txn;

 virtual task body();
     txn = alu_seq_item::type_id::create("txn");
    wait_for_grant();
  txn.randomize()with {
      txn.mode == 0;
      txn.ce == 1; 
      txn.cmd == 4'b1101;
      txn.delay < 8;
    };
    send_request(txn);
    wait_for_item_done();

    if(txn.inp_valid == 2'b01 || txn.inp_valid == 2'b10) begin
     txn.opa.rand_mode(0); 
     txn.opb.rand_mode(0);
     txn.inp_valid.rand_mode(0);
     txn.delay.rand_mode(0);
      repeat (txn.delay) begin
       txn.delay.rand_mode(0);
       wait_for_grant();
        txn.randomize()with {
          txn.mode == 0; 
          txn.ce == 1; 
          txn.cmd == 4'b1101;
        };
       send_request(txn);
       wait_for_item_done();
       end
      txn.inp_valid.rand_mode(1);
      //txn.delay.rand_mode(1);
      wait_for_grant();
      txn.randomize()with {
        txn.mode == 0; 
        txn.ce == 1;
        txn.cmd == 4'b1101;
        txn.inp_valid==2'b11;
       };
       send_request(txn);
       wait_for_item_done();
    end
  endtask
endclass


// //------------------------------------------------------------------------------
// // Class       : set_cout_seq
// // Description : Test for cout flag
// //------------------------------------------------------------------------------

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

// //------------------------------------------------------------------------------
// // Class       : set_oflow_seq
// // Description : Test for oflow flag
// //------------------------------------------------------------------------------

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

// //------------------------------------------------------------------------------
// // Class       : set_g_seq
// // Description : Test for g flag
// //------------------------------------------------------------------------------

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

// //------------------------------------------------------------------------------
// // Class       : set_l_seq
// // Description : Test for l flag
// //------------------------------------------------------------------------------

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
// // Class       : set_e_seq
// // Description : Test for e flag
// //------------------------------------------------------------------------------

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
// // Class       : set_err_seq
// // Description : Test for err flag
// //---------------------------------------------------------------------------

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


