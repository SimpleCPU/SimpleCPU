`ifndef SHA256_TRANSACTION_SV
`define SHA256_TRANSACTION_SV
// sha256 UVM-TB Sequence Item
// Sequence item creates the single transaction
// to be driven on the sha256 module using the
// sha256_driver. It defines the various params
// and signals to be used.
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

class sha256_transaction extends uvm_sequence_item;
    `uvm_object_utils (sha256_transaction)

    // Declare all the properties
    bit         start;
    bit[159:0]  cv;
    bit         use_prev_cv;
    bit[511:0]  y;

    function new (string name = "sha256_transaction");
        super.new (name);
    endfunction

endclass
`endif
