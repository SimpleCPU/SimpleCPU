`ifndef SHA256_DRIVER_SV
`define SHA256_DRIVER_SV
// The sha256 Driver
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
        forever
        begin
            seq_item_port.get_next_item (sha256_req);
            `uvm_info ("DRIVER", $sformatf ("Input is %d", sha256_req.start), UVM_NONE)
            @ (posedge sha256_vif.clk);
            seq_item_port.item_done();
        end
    endtask
    
endclass
`endif
