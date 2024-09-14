//------------------------------------------------------------------------------
// Project      : ALU 
// File Name    : alu_coverage.sv
// Developers   : 
// Created Date : 01/08/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

`uvm_analysis_imp_decl(_mon_ip)
`uvm_analysis_imp_decl(_mon_op)


class alu_cov extends uvm_subscriber #(alu_seq_item);
  `uvm_component_utils(alu_cov)
  
  uvm_analysis_imp_mon_ip #(alu_seq_item,alu_cov)mon_ip_imp;
  uvm_analysis_imp_mon_op #(alu_seq_item,alu_cov)mon_op_imp;
  
  alu_seq_item seq_item_wr;
  alu_seq_item seq_item_rd;
  
  covergroup fun_cov_wr ;
    coverpoint seq_item_wr.inp_valid{
      bins inp_valid_00={2'b00};
      bins inp_valid_01={2'b01};
      bins inp_valid_10={2'b10};
      bins inp_valid_11={2'b11};
    }
    MODE: coverpoint seq_item_wr.mode{
      bins mode_0 ={0};
      bins mode_1={1};
    } 
    CMD: coverpoint seq_item_wr.cmd{
      bins cmd[]={[0:$]};
      ignore_bins b1 ={14,15};
    }
    coverpoint seq_item_wr.ce{
      bins ce_0={0};
      bins ce_1={1};
    }
    coverpoint seq_item_wr.opa{
      bins opa_bin = {[0:$]};
    }
    coverpoint seq_item_wr.opb{
      bins opb_bin = {[0:$]};
    }
    coverpoint seq_item_wr.cin{
      bins cin_0={0};
      bins cin_1={1};
    }
    MODE_CMD : cross  MODE,CMD 
            { ignore_bins b2= binsof(CMD) intersect {11,12,13} && binsof(MODE) intersect {1};}
  endgroup:fun_cov_wr

                 covergroup fun_cov_rd;
                      coverpoint seq_item_rd.err{
                           bins err_0 ={0};
                           bins err_1 = {1};
                      }
                      coverpoint seq_item_rd.oflow{
                           bins oflow_0 = {0};
                           bins oflow_1 = {1};
                      }
                      coverpoint seq_item_rd.g{
                           bins g_0 = {0};
                           bins g_1 = {1};
                      }
                      coverpoint seq_item_rd.l{
                           bins l_0 = {0};
                           bins l_1 = {1};
                      }
                      coverpoint seq_item_rd.e{
                           bins e_0 = {0};
                           bins e_1 = {1};
                      }
                      coverpoint seq_item_rd.cout{
                           bins cout_0 = {0};
                           bins cout_1 = {1};
                      }
                      coverpoint seq_item_rd.res{
                           bins result = {[0:$]};
                       }
                 endgroup:fun_cov_rd

 

         real wr_cov_value,rd_cov_value;
 
        
        function new(string name="alu_cov",uvm_component parent=null);
                super.new(name,parent);
          mon_ip_imp=new("mon_ip_imp",this);
          mon_op_imp=new("mon_op_imp",this);
          fun_cov_wr =new();
          fun_cov_rd =new();
        endfunction:new

  
  virtual function void write_mon_ip (alu_seq_item item);
      this.seq_item_wr= item; 
    fun_cov_wr.sample();
  endfunction
  
  virtual function void write_mon_op (alu_seq_item item);
     this.seq_item_rd= item;
    fun_cov_rd.sample();
  endfunction
        
        virtual function void write(alu_seq_item t);
              
        endfunction

         
      virtual  function void extract_phase(uvm_phase phase);
          super.extract_phase(phase);
          
          wr_cov_value = fun_cov_wr.get_coverage();
          rd_cov_value = fun_cov_rd.get_coverage();
        `uvm_info("COVERAGE",$sformatf("\n Input coverage is %f \n output coverage is %f",wr_cov_value,rd_cov_value),UVM_LOW);
        endfunction
    

endclass
