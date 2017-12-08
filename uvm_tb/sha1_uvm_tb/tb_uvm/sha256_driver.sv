`ifndef SHA256_DRIVER_SV
`define SHA256_DRIVER_SV
// The sha256 Driver
`timescale 1ns/10ps
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "sha256_interface.sv"
`include "sha256_transaction.sv"

class sha256_driver extends uvm_driver # (sha256_transaction);
    `uvm_component_utils (sha256_driver)

    virtual sha256_interface sha256_vif;

    function new (string name = "sha256_agent", uvm_component parent);
        super.new (name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        if (!uvm_config_db #(virtual sha256_interface)::get (this, "", "sha256_vif", sha256_vif)) begin
          `uvm_fatal ("", $sformatf("Failed to find %s.sha256_interface", get_full_name()));
        end
        `uvm_info ("DRIVER", "sha256_vif connected", UVM_NONE)
    endfunction

    task run_phase (uvm_phase phase);
        sha256_transaction sha256_req;
        int k;
        int l;
        forever
        begin
            seq_item_port.get_next_item (sha256_req);
            `uvm_info ("DRIVER", $sformatf ("Input is %d", sha256_req.sha_gen.msg_string), UVM_NONE)
            @(posedge sha256_vif.clk);
            sha256_vif.cmd_i    = 'b010;
            sha256_vif.cmd_w_i  = 'b1;
            `uvm_info ("DRIVER", $sformatf ("Input is %3dx512-bits long", sha256_req.sha_gen.preprocessor.N), UVM_NONE)
            l = sha256_req.sha_gen.preprocessor.N-1;
            sha256_req.sha_gen.preprocessor.padded_msg = {"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq", 1'b1,63'b0,448'b0,64'd448};
            for (int i = 0; i < sha256_req.sha_gen.preprocessor.N; i++) begin
                int j = 511;
                @(posedge sha256_vif.clk);
                sha256_vif.cmd_w_i  = 'b0;
                // Form the initial 16 message schedules
                for (k = 0; k < 16; k++) begin
                    @(posedge sha256_vif.clk);
                    sha256_vif.text_i = sha256_req.sha_gen.preprocessor.padded_msg[((512*l)+j)-:32];
                    $display ("msg[%3d:%3d]: %x", ((512*l)+j), ((512*l)+j)-32, sha256_vif.text_i) ;
                    j = j - 32;
                end
                l--;
                repeat (10) @(posedge sha256_vif.clk);
                while (sha256_vif.cmd_o[3])
                    @(posedge sha256_vif.clk);
                repeat (5) @(posedge sha256_vif.clk);
                #100;
                sha256_vif.cmd_i = 'b110;
                sha256_vif.cmd_w_i = 'b1;
            end
            sha256_vif.cmd_i = 'b1;
            sha256_vif.cmd_w_i = 'b1;
            repeat (5) @(posedge sha256_vif.clk);
            @(posedge sha256_vif.clk);
            sha256_vif.cmd_w_i = 'b0;
            for (int i = 8; i > 0; i--) begin
              @(posedge sha256_vif.clk);
              #1;
              sha256_vif.cmd_w_i = 'b0;
              sha256_vif.sha256_hash[(32*i-1)-:32] = sha256_vif.text_o;
              $display ("Text[%3d:%3d] is %x", 32*i-1, (32*i-1)-31, sha256_vif.text_o);
            end
            sha256_req.check (sha256_vif.sha256_hash);
            seq_item_port.item_done();
        end
    endtask
    
endclass
`endif
