//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_package.sv
// Developers   : Team - 2 
// Created Date : 03/09/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "alu_design.v"
`include "alu_define.svh"
`include "alu_interface.sv"
`include "alu_sequence_item.sv"
`include "alu_sequence.sv"
`include "alu_sequencer.sv"
`include "alu_driver.sv"
`include "alu_ip_monitor.sv"
`include "alu_op_monitor.sv"
`include "alu_agent_active.sv"
`include "alu_agent_passive.sv"
`include "alu_scoreboard.sv"
`include "alu_environment.sv"
`include "alu_test.sv"
