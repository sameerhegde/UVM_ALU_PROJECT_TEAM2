//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_scoreboard.sv
// Developers   : Team-2
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

`uvm_analysis_imp_decl (_ip_mon)
`uvm_analysis_imp_decl (_op_mon)

class alu_scb extends uvm_scoreboard;
  
  // Factory registration
  `uvm_component_utils (alu_scb)
  
  // Class constructor
  function new (string name = "alu_scb", uvm_component parent);
    super.new(name,parent);
  endfunction: new
  
  virtual alu_if vif;
  // Analysis implemenatation ports
  uvm_analysis_imp_ip_mon #(alu_seq_item, alu_scb) ip_mon_port;
  uvm_analysis_imp_op_mon #(alu_seq_item, alu_scb) op_mon_port;

  alu_seq_item ip_queue[$];
  alu_seq_item op_queue[$];
  
        alu_seq_item exp_trans;
        alu_seq_item act_trans;
  // Count variable for compare status and total tests ran
  //int pass, fail, total;

  // Build phase
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    ip_mon_port = new ("ip_mon_port", this);
    op_mon_port = new ("op_mon_port", this);
    if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal ("No vif", {"Set virtual interface to: ", get_full_name (), ".vif"});
  endfunction: build_phase
 
  // Do something with the monitor_write txn
  virtual function void write_ip_mon (alu_seq_item item);
    ip_queue.push_back(item);
  endfunction
  
  virtual function void write_op_mon (alu_seq_item item);
    op_queue.push_back(item);
  endfunction
    
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
     forever begin   
        wait(ip_queue.size() > 0 && op_queue.size() > 0);
        exp_trans = ip_queue.pop_front();
        act_trans = op_queue.pop_front();
        
       $display(" [%0t] SCOREBOARD RUN PHASE mode = %d ip_valid = %d  cmd = %d  opa = %d opb = %d  ce = %d cin = %d",$time,exp_trans.mode,exp_trans.inp_valid,exp_trans.cmd,exp_trans.opa,exp_trans.opb,exp_trans.ce,exp_trans.cin);
        
       $display(" [%0t] SCOREBOARD RUN PHASE res = %d oflow = %d  cout = %d g = %d  l = %d e = %d err =%d",$time,act_trans.res,act_trans.oflow,act_trans.cout,act_trans.g,act_trans.l,act_trans.e,act_trans.err);
        
        
        compare(exp_trans,act_trans);
     end
endtask

task compare(alu_seq_item exp_trans,alu_seq_item act_trans);
  
  $display(" [%0t] COMPARE mode = %d ip_valid = %d  cmd = %d  opa = %d opb = %d  ce = %d cin = %d",$time,exp_trans.mode,exp_trans.inp_valid,exp_trans.cmd,exp_trans.opa,exp_trans.opb,exp_trans.ce,exp_trans.cin);
        
  $display(" [%0t] COMPARE RUN PHASE res = %d oflow = %d  cout = %d g = %d  l = %d e = %d err =%d",$time,act_trans.res,act_trans.oflow,act_trans.cout,act_trans.g,act_trans.l,act_trans.e,act_trans.err);

  
  if(exp_trans.ce ==1)
    begin
      if(exp_trans.mode ==1 )
        begin
          case(exp_trans.cmd)
            0:begin
              if(exp_trans.inp_valid == 2'b11)
                exp_trans.res = exp_trans.opa + exp_trans.opb;
              else
                exp_trans.res = 'bz;
            end
            1:begin
              if(exp_trans.inp_valid == 2'b11)
                exp_trans.res = exp_trans.opa - exp_trans.opb;
              else
                exp_trans.res = 'bz;
            end
            2:begin
              if (exp_trans.inp_valid == 2'b11)
                exp_trans.res = exp_trans.opa + exp_trans.opb + exp_trans.cin;
              else
                exp_trans.res = 'bz;
            end
            3:begin
              if (exp_trans.inp_valid == 2'b11)
                exp_trans.res = exp_trans.opa - exp_trans.opb - exp_trans.cin;
              else      
                exp_trans.res = 'bz;
            end
            4:begin
              if (exp_trans.inp_valid == 2'b01)
                  exp_trans.res = exp_trans.opa + 1'b1;
                else
                  exp_trans.res = 'bz;
            end
            5:begin
              if (exp_trans.inp_valid == 2'b01)
                  exp_trans.res = exp_trans.opa - 1'b1;
                else
                  exp_trans.res = 'bz;
            end
            6:begin
              if (exp_trans.inp_valid == 2'b10)
                  exp_trans.res = exp_trans.opb + 1'b1;
                else
                  exp_trans.res = 'bz;
            end
            7:begin
              if (exp_trans.inp_valid == 2'b10)
                  exp_trans.res = exp_trans.opb - 1'b1;
                else
                  exp_trans.res = 'bz;
            end
            8:begin
              if (exp_trans.inp_valid == 2'b11) begin
                if (exp_trans.opa > exp_trans.opb)  begin
                  exp_trans.g = 'b1; exp_trans.l = 'b0; exp_trans.e = 'b0;
                end
                else if (exp_trans.opa < exp_trans.opb) begin
                  exp_trans.g = 'b0; exp_trans.l = 'b1; exp_trans.e = 'b0;
                end
                else begin
                  exp_trans.g = 'b0; exp_trans.l = 'b0; exp_trans.e = 'b1;
                end
              end
            end
            9:begin
              if (exp_trans.inp_valid == 2'b11)
                exp_trans.res = (exp_trans.opa + 1'b1) * (exp_trans.opb + 1'b1);
              else
                exp_trans.res = 'bz;              
            end
            10:begin
              if (exp_trans.inp_valid == 2'b11)
                exp_trans.res = (exp_trans.opa << 1) * exp_trans.opb;
              else
                exp_trans.res = 'bz;
            end
            default: exp_trans.res = 'bz;
          endcase
        end
      else
        begin
          case(exp_trans.cmd)
            0:begin
              if(exp_trans.inp_valid == 2'b11)
                exp_trans.res = exp_trans.opa && exp_trans.opb;
              else
                exp_trans.res = 'bz;
            end
            1:begin
              if(exp_trans.inp_valid == 2'b11)
                exp_trans.res = ~(exp_trans.opa && exp_trans.opb);
              else
                exp_trans.res = 'bz;
            end
            2:begin
              if(exp_trans.inp_valid == 2'b11)
                exp_trans.res = exp_trans.opa || exp_trans.opb;
              else
                exp_trans.res = 'bz;
            end
            3:begin
              if(exp_trans.inp_valid == 2'b11)
                exp_trans.res = ~(exp_trans.opa || exp_trans.opb);
              else
                exp_trans.res = 'bz;
            end
            4:begin
              if(exp_trans.inp_valid == 2'b11)
                exp_trans.res = exp_trans.opa ^ exp_trans.opb;
              else
                exp_trans.res = 'bz;
            end
            5:begin
              if(exp_trans.inp_valid == 2'b11)
                exp_trans.res = ~(exp_trans.opa ^ exp_trans.opb);
              else
                exp_trans.res = 'bz;
            end
            6:begin
              if(exp_trans.inp_valid == 2'b01)
                exp_trans.res = ~ exp_trans.opa;
              else
                exp_trans.res = 'bz;
            end
            7:begin
              if(exp_trans.inp_valid == 2'b10)
                exp_trans.res = ~ exp_trans.opb;
              else
                exp_trans.res = 'bz;
            end
            8:begin
              if(exp_trans.inp_valid == 2'b01)
                exp_trans.res =  exp_trans.opa >> 1;
              else
                exp_trans.res = 'bz;
            end
            9:begin
              if(exp_trans.inp_valid == 2'b01)
                exp_trans.res =  exp_trans.opa << 1;
              else
                exp_trans.res = 'bz;
            end
            10:begin
              if(exp_trans.inp_valid == 2'b10)
                exp_trans.res =  exp_trans.opb >> 1;
              else
                exp_trans.res = 'bz;
            end
            11:begin
              if(exp_trans.inp_valid == 2'b10)
                exp_trans.res =  exp_trans.opb << 1;
              else
                exp_trans.res = 'bz;
            end
          endcase
        end
    end
  
  if(exp_trans.res == act_trans.res)
    `uvm_info("COMPARE", $sformatf(" Transaction Passed! ACT=%d, EXP=%d", act_trans.res, exp_trans.res),UVM_LOW)
  else
    `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d",  act_trans.res, exp_trans.res));
    
  if(exp_trans.cout == act_trans.cout)
    `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", act_trans.cout, exp_trans.cout), UVM_LOW)
  else
    `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d",  act_trans.cout, exp_trans.cout))  
  
  if(exp_trans.oflow == act_trans.oflow)
    `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", act_trans.oflow, exp_trans.oflow), UVM_LOW)
  else
    `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d",  act_trans.oflow, exp_trans.oflow)) 
    
  if(exp_trans.g == act_trans.g)
    `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", act_trans.g, exp_trans.g), UVM_LOW)
  else
    `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d",  act_trans.g, exp_trans.g))
  
  if(exp_trans.l == act_trans.l)
    `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", act_trans.l, exp_trans.l), UVM_LOW)
  else
    `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d",  act_trans.l, exp_trans.l))  
    
  if(exp_trans.err == act_trans.err)
    `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", act_trans.err, exp_trans.err), UVM_LOW)
  else
    `uvm_error("COMPARE", $sformatf("Transaction faierred! ACT=%d, EXP=%d",  act_trans.err, exp_trans.err))
    
  if(exp_trans.e == act_trans.e)
    `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", act_trans.e, exp_trans.e), UVM_LOW)
  else
    `uvm_error("COMPARE", $sformatf("Transaction faieed! ACT=%d, EXP=%d",  act_trans.e, exp_trans.e))
    
endtask

  
endclass
   
  
