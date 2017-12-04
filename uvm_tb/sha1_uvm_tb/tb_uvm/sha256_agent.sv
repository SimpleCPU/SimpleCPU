`ifndef SHA256_AGENT_SV
`define SHA256_AGENT_SV
// The sha256 Agent
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "sha256_driver.sv"
`include "sha256_sequencer.sv"

class sha256_agent extends uvm_agent;
    `uvm_component_utils (sha256_agent)

    sha256_driver     sha256_driver_h;
    sha256_sequencer  sha256_sequencer_h;

    function new (string name = "sha256_agent", uvm_component parent);
        super.new (name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        sha256_driver_h       = sha256_driver::type_id::create ("sha256_driver", this);
        sha256_sequencer_h    = sha256_sequencer::type_id::create ("sha256_sequencer", this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
        sha256_driver_h.seq_item_port.connect (
                sha256_sequencer_h.seq_item_export);
    endfunction

endclass
`endif
