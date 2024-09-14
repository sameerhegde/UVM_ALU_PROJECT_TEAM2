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
  

  // Build phase
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    ip_mon_port = new ("ip_mon_port", this);
    op_mon_port = new ("op_mon_port", this);
    if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal ("No vif", {"Set virtual interface to: ", get_full_name (), ".vif"});
  endfunction: build_phase
  
  virtual function void write_ip_mon (alu_seq_item item);
    ip_queue.push_back(item);
  endfunction
  
  virtual function void write_op_mon (alu_seq_item item);
    op_queue.push_back(item);
  endfunction
  
  extern function void single_op_arithmetic(alu_seq_item exp_trans, alu_seq_item act_trans);
  extern function void two_op_arithmetic( alu_seq_item exp_trans,  alu_seq_item act_trans);
  extern function void single_op_logical(alu_seq_item exp_trans, alu_seq_item act_trans); 
  extern function void two_op_logical(alu_seq_item exp_trans, alu_seq_item act_trans);   
  extern task run_phase(uvm_phase phase);
    
endclass
    
  int MATCH;
  int MISMATCH;
    
    function void match(alu_seq_item exp_trans, alu_seq_item act_trans); 
      MATCH++;
      `uvm_info("SEQUENCE_MATCHED","Matched",UVM_LOW);
      `uvm_info("MATCH", $sformatf("match count = %0d", MATCH), UVM_LOW);
    endfunction
    
    function void mismatch(alu_seq_item exp_trans, alu_seq_item act_trans);	  
      MISMATCH++; 	
      `uvm_info("SEQUENCE_MISMATCHED","Mismatched",UVM_LOW);
      `uvm_info("MISMATCH", $sformatf("mismatch count = %0d", MISMATCH), UVM_LOW);
	endfunction	
  
  
  function void alu_scb::single_op_arithmetic(alu_seq_item exp_trans, alu_seq_item act_trans);
    if(exp_trans.cmd inside {[4:7]})
      begin
        if(exp_trans.inp_valid==2'b01 || exp_trans.inp_valid ==2'b11)
          begin
            case(exp_trans.cmd)
             4:begin //INC_A
               exp_trans.res = exp_trans.opa + 1;
               exp_trans.cout = exp_trans.res[`DATA_WIDTH];	
               if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
                 match(exp_trans,act_trans);
               else 
                 mismatch(exp_trans,act_trans);
             end 
             5:begin //DEC_A
               exp_trans.res = exp_trans.opa - 1;
               exp_trans.cout = exp_trans.res[`DATA_WIDTH];
               if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
                 match(exp_trans,act_trans);
               else 
                 mismatch(exp_trans,act_trans);
             end
           endcase
            `uvm_info("EXPECTED",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,exp_trans.res,exp_trans.cout,exp_trans.oflow,exp_trans.g,exp_trans.l,exp_trans.e,exp_trans.err),UVM_LOW)
            `uvm_info("ACTUAL",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,act_trans.res,act_trans.cout,act_trans.oflow,act_trans.g,act_trans.l,act_trans.e,act_trans.err),UVM_LOW)
         end
        else if(exp_trans.inp_valid == 2'b10 || exp_trans.inp_valid == 2'b11)
          begin
            case(exp_trans.cmd)
              6:begin //INC_B
                exp_trans.res = exp_trans.opb + 1'b1;
                exp_trans.cout = exp_trans.res[`DATA_WIDTH];
                if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
                  match(exp_trans,act_trans);
                else 
                  mismatch(exp_trans,act_trans);
              end
              7:begin //DEC_B
                exp_trans.res = exp_trans.opb - 1'b1;
                exp_trans.cout = exp_trans.res[`DATA_WIDTH];
                if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
                  match(exp_trans,act_trans);
                else 
                  mismatch(exp_trans,act_trans);
              end
            endcase
            `uvm_info("EXPECTED",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,exp_trans.res,exp_trans.cout,exp_trans.oflow,exp_trans.g,exp_trans.l,exp_trans.e,exp_trans.err),UVM_LOW)
            `uvm_info("ACTUAL",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,act_trans.res,act_trans.cout,act_trans.oflow,act_trans.g,act_trans.l,act_trans.e,act_trans.err),UVM_LOW)
          end
        else
          `uvm_error("scoreboard","ERROR")
      end
  endfunction
  
  function void alu_scb::two_op_arithmetic(alu_seq_item exp_trans, alu_seq_item act_trans);
        if(exp_trans.inp_valid == 2'b11)
          begin
            case(exp_trans.cmd)
              0:begin //ADD
                exp_trans.res = exp_trans.opa + exp_trans.opb;
                exp_trans.cout = exp_trans.res[`DATA_WIDTH];
                if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
                  match(exp_trans,act_trans);
                else 
                  mismatch(exp_trans,act_trans);
              end
              1:begin //SUB
                exp_trans.res = exp_trans.opa - exp_trans.opb;
                exp_trans.cout = exp_trans.res[`DATA_WIDTH];
                if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
                  match(exp_trans,act_trans);
                else 
                  mismatch(exp_trans,act_trans);
              end
              2:begin //ADD_CIN
                exp_trans.res = exp_trans.opa + exp_trans.opb + exp_trans.cin;
                exp_trans.cout = exp_trans.res[`DATA_WIDTH];
                if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
                  match(exp_trans,act_trans);
		     	else 
                  mismatch(exp_trans,act_trans);
              end
              3:begin //ADD_CIN
                exp_trans.res = exp_trans.opa - exp_trans.opb - exp_trans.cin;
                exp_trans.cout = exp_trans.res[`DATA_WIDTH];
                if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
                  match(exp_trans,act_trans);
                else 
                  mismatch(exp_trans,act_trans);
              end
              8:begin //CMP
                if (exp_trans.opa > exp_trans.opb)
                  begin
                    exp_trans.g = 'b1;
                    exp_trans.l = 0;
                    exp_trans.e = 0;
                  end
                else if (exp_trans.opa < exp_trans.opb)
                  begin
                    exp_trans.l = 'b1;
                    exp_trans.g = 0;
                    exp_trans.e = 0;
                  end
                else
                  begin
                    exp_trans.e = 'b1;
                    exp_trans.g = 0;
                    exp_trans.l = 0;
                  end
                if((act_trans.e == exp_trans.e) && (act_trans.g == exp_trans.g) && (act_trans.l == exp_trans.l))
                  match(exp_trans,act_trans);
                else 
                  mismatch(exp_trans,act_trans);
              end
              9:begin //INC-OPA MUL-OPB
                exp_trans.res = (exp_trans.opa + 1'b1) * (exp_trans.opb + 1'b1);
                exp_trans.oflow = exp_trans.res[`DATA_WIDTH];
                if((act_trans.res == exp_trans.res)&&(act_trans.oflow == exp_trans.oflow))
                  match(exp_trans,act_trans);
		     	else 
                  mismatch(exp_trans,act_trans);
              end
              10:begin //LEFT_SHIFT-OPA MUL-OPB
                exp_trans.res = (exp_trans.opa << 1) * exp_trans.opb;
                exp_trans.oflow = exp_trans.res[`DATA_WIDTH];
                if((act_trans.res == exp_trans.res)&&(act_trans.oflow == exp_trans.oflow))
                  match(exp_trans,act_trans);
                else 
                  mismatch(exp_trans,act_trans);
              end
            endcase
                 `uvm_info("EXPECTED",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,exp_trans.res,exp_trans.cout,exp_trans.oflow,exp_trans.g,exp_trans.l,exp_trans.e,exp_trans.err),UVM_LOW)
            `uvm_info("ACTUAL",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,act_trans.res,act_trans.cout,act_trans.oflow,act_trans.g,act_trans.l,act_trans.e,act_trans.err),UVM_LOW)
          end
  endfunction
        
         function void alu_scb::single_op_logical(alu_seq_item exp_trans, alu_seq_item act_trans);
  if(exp_trans.cmd inside {[6:11]})
    begin
      if(exp_trans.inp_valid == 2'b01 || exp_trans.inp_valid == 2'b11)
        begin
          case(exp_trans.cmd)
            6:begin //NOT A
              exp_trans.res = ~(exp_trans.opa);
              if(act_trans.res == exp_trans.res)
                 match(exp_trans,act_trans);
               else 
                 mismatch(exp_trans,act_trans);
            end
            8:begin //SHR A
              exp_trans.res =exp_trans.opa >> 1;
              if(act_trans.res == exp_trans.res)
                 match(exp_trans,act_trans);
               else 
                 mismatch(exp_trans,act_trans);
            end
            9:begin //SHL A
              exp_trans.res = exp_trans.opa << 1;
              if(act_trans.res == exp_trans.res)
                 match(exp_trans,act_trans);
               else 
                 mismatch(exp_trans,act_trans);
            end
          endcase
          `uvm_info("EXPECTED",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,exp_trans.res,exp_trans.cout,exp_trans.oflow,exp_trans.g,exp_trans.l,exp_trans.e,exp_trans.err),UVM_LOW)
            `uvm_info("ACTUAL",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,act_trans.res,act_trans.cout,act_trans.oflow,act_trans.g,act_trans.l,act_trans.e,act_trans.err),UVM_LOW)
        end
      else if(exp_trans.inp_valid == 2'b10 || exp_trans.inp_valid == 2'b11)
        begin
          case(exp_trans.cmd)
            7:begin //NOT B
              exp_trans.res = ~(exp_trans.opb);
              if(act_trans.res == exp_trans.res)
                 match(exp_trans,act_trans);
               else 
                 mismatch(exp_trans,act_trans);
            end
            10:begin //SHR B
              exp_trans.res = exp_trans.opb >> 1;
              if(act_trans.res == exp_trans.res)
                 match(exp_trans,act_trans);
               else 
                 mismatch(exp_trans,act_trans);
            end
            11:begin //SHL B
              exp_trans.res = exp_trans.opb << 1;
              if(act_trans.res == exp_trans.res)
                 match(exp_trans,act_trans);
               else 
                 mismatch(exp_trans,act_trans);
            end
          endcase
          `uvm_info("EXPECTED",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,exp_trans.res,exp_trans.cout,exp_trans.oflow,exp_trans.g,exp_trans.l,exp_trans.e,exp_trans.err),UVM_LOW)
            `uvm_info("ACTUAL",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,act_trans.res,act_trans.cout,act_trans.oflow,act_trans.g,act_trans.l,act_trans.e,act_trans.err),UVM_LOW)
        end
      else
        `uvm_error("scoreboard","Error");
    end
endfunction
        
   function void alu_scb :: two_op_logical(alu_seq_item exp_trans,alu_seq_item act_trans);
  if(exp_trans.inp_valid == 2'b11)
    begin
      case(exp_trans.cmd)
        0:begin //AND
          exp_trans.res = exp_trans.opa & exp_trans.opb;
          if((act_trans.res == exp_trans.res)&&(act_trans.cout == exp_trans.cout))
            match(exp_trans,act_trans);
          else 
            mismatch(exp_trans,act_trans);
        end
        1:begin //NAND
          exp_trans.res = ~(exp_trans.opa & exp_trans.opb);
          if(act_trans.res == exp_trans.res)
            match(exp_trans,act_trans);
          else 
            mismatch(exp_trans,act_trans);
        end
        2:begin //OR
          exp_trans.res = exp_trans.opa | exp_trans.opb;
          if(act_trans.res == exp_trans.res)
            match(exp_trans,act_trans);
          else 
            mismatch(exp_trans,act_trans);
        end
        3:begin //NOR
          exp_trans.res = ~(exp_trans.opa | exp_trans.opb);
          if(act_trans.res == exp_trans.res)
            match(exp_trans,act_trans);
          else 
            mismatch(exp_trans,act_trans);
        end
        4:begin //XOR
          exp_trans.res = exp_trans.opa ^ exp_trans.opb;
          if(act_trans.res == exp_trans.res)
            match(exp_trans,act_trans);
          else 
            mismatch(exp_trans,act_trans);
        end
        5:begin //XNOR
          exp_trans.res = ~(exp_trans.opa ^ exp_trans.opb);
          if(act_trans.res == exp_trans.res)
            match(exp_trans,act_trans);
          else 
            mismatch(exp_trans,act_trans);
        end
        12:begin //ROL
          if(exp_trans.opb[7:4] > 0) begin
            exp_trans.err = 1;
          end
          case(exp_trans.opb[2:0])
            3'b000: exp_trans.res = {1'b0,exp_trans.opa};
            3'b001: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-2:0], exp_trans.opa[`DATA_WIDTH-1]}};
            3'b010: exp_trans.res = {1'b0, {exp_trans.opa[`DATA_WIDTH-3:0], exp_trans.opa[`DATA_WIDTH-1:6]}};
            3'b011: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-4:0], exp_trans.opa[`DATA_WIDTH-1:5]}};
            3'b100: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-5:0], exp_trans.opa[`DATA_WIDTH-1:4]}};
            3'b101: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-6:0], exp_trans.opa[`DATA_WIDTH-1:3]}};
            3'b110: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-7:0], exp_trans.opa[`DATA_WIDTH-1:2]}};
            3'b111: exp_trans.res = {1'b0,{exp_trans.opa[0], exp_trans.opa[`DATA_WIDTH-1:1]}};
          endcase
          if(exp_trans.res == act_trans.res)
            match(exp_trans, act_trans);
          else
            mismatch(exp_trans, act_trans);
        end
         13:begin //ROR
           if(exp_trans.opb[7:4] > 0) begin
             exp_trans.err = 1;
           end
           case(exp_trans.opb[2:0])
             3'b000: exp_trans.res = {1'b0,exp_trans.opa};
             3'b001: exp_trans.res = {1'b0,{exp_trans.opa[0], exp_trans.opa[`DATA_WIDTH-1:1]}};
             3'b010: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-7:0], exp_trans.opa[`DATA_WIDTH-1:2]}};
             3'b011: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-6:0], exp_trans.opa[`DATA_WIDTH-1:3]}};
             3'b100: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-5:0], exp_trans.opa[`DATA_WIDTH-1:4]}};
             3'b101: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-4:0], exp_trans.opa[`DATA_WIDTH-1:5]}};
             3'b110: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-3:0], exp_trans.opa[`DATA_WIDTH-1:6]}};
             3'b111: exp_trans.res = {1'b0,{exp_trans.opa[`DATA_WIDTH-2:0], exp_trans.opa[`DATA_WIDTH-1]}};
           endcase
           if(exp_trans.res == act_trans.res)
             match(exp_trans, act_trans);
           else
             mismatch(exp_trans, act_trans);
         end
      endcase
      `uvm_info("EXPECTED",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,exp_trans.res,exp_trans.cout,exp_trans.oflow,exp_trans.g,exp_trans.l,exp_trans.e,exp_trans.err),UVM_LOW)
            `uvm_info("ACTUAL",$sformatf("[%0t] res=%d,cout=%d,oflow=%d,g=%d,l=%d,e=%d,err=%d",$time,act_trans.res,act_trans.cout,act_trans.oflow,act_trans.g,act_trans.l,act_trans.e,act_trans.err),UVM_LOW)
    end
endfunction 
    
    
    task alu_scb::run_phase (uvm_phase phase);
   super.run_phase(phase);
     forever begin   
        wait(ip_queue.size() > 0 && op_queue.size() > 0)
       begin
         exp_trans = ip_queue.pop_front();
         act_trans = op_queue.pop_front();
         
         if(exp_trans.ce ==1)
           begin
             if(exp_trans.mode ==1)
               begin
                 if(exp_trans.cmd inside {[4:7]})
                   single_op_arithmetic(exp_trans,act_trans);
                 else
                   two_op_arithmetic(exp_trans,act_trans);
               end
             else
               begin
                 if(exp_trans.cmd inside {[6:11]})
                   single_op_logical(exp_trans,act_trans);
                 else
                   two_op_logical(exp_trans,act_trans);
               end
           end
         if(vif.rst)
           begin
             exp_trans.res <= 'bz;
             exp_trans.cout <= 'bz;
             exp_trans.oflow <= 'bz;
             exp_trans.g <= 'bz;
             exp_trans.l <= 'bz;
             exp_trans.e <= 'bz;
             exp_trans.err <= 'bz;
           end
       end
     end
endtask
   
  
