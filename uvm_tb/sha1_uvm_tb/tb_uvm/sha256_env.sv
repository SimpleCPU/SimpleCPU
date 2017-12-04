// The top sha256 Environment

`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "sha256_agent.sv"

class sha256_env extends uvm_env;
    `uvm_component_utils(sha256_env)

    sha256_agent sha256_agent_h;

    function new (string name = "sha256_env", uvm_component parent);
        super.new (name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        sha256_agent_h = sha256_agent::type_id::create ("sha256_agent_h", this);
    endfunction

endclass
