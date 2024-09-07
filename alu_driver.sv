//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_driver.sv
// Developers   : Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
class alu_drv extends uvm_driver #(alu_seq_item);

  `uvm_component_utils (alu_drv);

  function new (string name = "alu_drv", uvm_component parent);
    super.new (name, parent);
  endfunction: new

  virtual alu_if vif;  
  
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal ("No vif", {"Set virtual interface to: ", get_full_name (), ".vif"});
  endfunction: build_phase

  alu_seq_item txn;

  virtual task run_phase(uvm_phase phase);
    forever
        begin
          `uvm_info("DRIVER","driver start",UVM_LOW)
          repeat(2) @(posedge vif.DRV.drv_cb);
          seq_item_port.get_next_item (txn);
          drive();   
          seq_item_port.item_done ();
        end
    
  endtask: run_phase

 // drive task...
  
 virtual task drive();
    if (vif.DRV.drv_cb.rst)
      begin
        vif.DRV.drv_cb.ce <= 'bz;
        vif.DRV.drv_cb.cin <= 'bz;
        vif.DRV.drv_cb.cmd <= 'bz;
        vif.DRV.drv_cb.opa <= 'bz;
        vif.DRV.drv_cb.opb <= 'bz;
        vif.DRV.drv_cb.mode <= 'bz;
        vif.DRV.drv_cb.inp_valid <= 'bz;
      end
    else
      begin
       vif.DRV.drv_cb.ce <= txn.ce; 
       vif.DRV.drv_cb.cin <= txn.cin;
       vif.DRV.drv_cb.cmd <= txn.cmd;     
       vif.DRV.drv_cb.opa <= txn.opa;
       vif.DRV.drv_cb.opb <= txn.opb;
       vif.DRV.drv_cb.mode <= txn.mode;
       vif.DRV.drv_cb.inp_valid <= txn.inp_valid;
     end
   `uvm_info("DRIVER",$sformatf(" [%0t] mode = %d ip_valid = %d  cmd = %d  opa = %d opb = %d  ce = %d cin = %d",$time,vif.DRV.drv_cb.mode,vif.DRV.drv_cb.inp_valid,vif.DRV.drv_cb.cmd,vif.DRV.drv_cb.opa,vif.DRV.drv_cb.opb,vif.DRV.drv_cb.ce,vif.DRV.drv_cb.cin),UVM_LOW)
  endtask
  
endclass: alu_drv
