`ifndef SHA256_TEST_SV
`define SHA256_TEST_SV
// SHA256 Test
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "sha256_sequence.sv"
`include "sha256_env.sv"

class sha256_test extends uvm_test;
    `uvm_component_utils (sha256_test)

    sha256_env sha256_env_h;

    function new (string name = "sha256_test", uvm_component parent);
        super.new (name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        sha256_env_h = sha256_env::type_id::create ("sha256_env_h", this);
    endfunction

    task run_phase (uvm_phase phase);
        sha256_sequence sha256_basic_seq_h;
        sha256_basic_seq_h = sha256_sequence::type_id::create ("sha256_basic_seq_h");
        phase.raise_objection (this);
        sha256_basic_seq_h.start (sha256_env_h.sha256_agent_h.sha256_sequencer_h);
        phase.drop_objection (this);
    endtask

endclass
`endif
