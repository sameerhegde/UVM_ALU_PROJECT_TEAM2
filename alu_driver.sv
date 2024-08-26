//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_driver.sv
// Developers   : 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class alu_drv extends uvm_driver #(alu_sequence_item);
`uvm_component_utils(alu_drv)

function new(string name = "alu_drv",uvm_component = null);
super.new(name,parent);
endfunction

virtual alu_interface drv_vif;

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual alu_interface)::get(this," ","vif",drv_vif))
`uvm_fatal("DRIVER","could not get vif")
endfunction

virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
forever begin
alu_sequence_item s_item;
`uvm_info("DRIVER","wait for item from sequencer",UVM_LOW)
seq_item_port.get_next_item(s_item);
//////////////////////////////////////
seq_item_port.item_done();
end
endtask

endclass
