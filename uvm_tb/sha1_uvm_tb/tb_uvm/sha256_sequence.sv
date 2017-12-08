`ifndef SHA256_SEQUENCE_SV
`define SHA256_SEQUENCE_SV
// SHA256 Sequence
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "sha256_transaction.sv"

import uvm_pkg::*;

class sha256_sequence extends uvm_sequence #(sha256_transaction);
    `uvm_object_utils (sha256_sequence)


    function new (string name = "sha256_sequence");
        super.new (name);
    endfunction

    task body ();
        sha256_transaction txn;
        txn = sha256_transaction::type_id::create ("txn");
        start_item (txn);
        finish_item (txn);
    endtask

endclass
`endif
