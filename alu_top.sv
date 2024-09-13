//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_top.sv
// Developers   : Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//----------------------------------------------------------------------------


`include "alu_package.sv"

module top ();
   
    bit clk,rst;

    always #5 clk = ~clk;
    
    initial begin
      rst = 0;
      //#10 rst =0;
     end

    alu_if intf(clk,rst);

    
    ALU_DESIGN dut (
        .OPA(intf.opa),
        .OPB(intf.opb),
           .CIN(intf.cin),
           .CLK(clk), 
           .RST(intf.rst),
           .CE(intf.ce),
           .MODE(intf.mode),
      	   .INP_VALID(intf.inp_valid),
           .CMD(intf.cmd),
           .COUT(intf.cout),
           .RES(intf.res),
           .OFLOW(intf.oflow),
           .G(intf.g),
           .E(intf.e),
           .L(intf.l),
           .ERR(intf.err)
      );

     initial begin 
       uvm_config_db #(virtual alu_if)::set(uvm_root::get(),"*","vif",intf);
     end
     
     initial begin

        run_test("alu_regression");
     end
  
endmodule
