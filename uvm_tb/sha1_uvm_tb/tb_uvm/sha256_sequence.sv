`ifndef SHA256_SEQUENCE_SV
`define SHA256_SEQUENCE_SV
// SHA256 Sequence
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "sha256_transaction.sv"

import uvm_pkg::*;

class sha256_sequence extends uvm_sequence #(sha256_transaction);
    `uvm_object_utils (sha256_sequence)
    int num_tests;

    function new (string name = "sha256_sequence");
        super.new (name);
        if (!($value$plusargs("NUM_TESTS=%d", num_tests)))
            num_tests = 5;
    endfunction

    task body ();
        for (int i = 0; i < num_tests; i++) begin
            sha256_transaction txn;
            txn = sha256_transaction::type_id::create ("txn");
            start_item (txn);
            finish_item (txn);
        end
    endtask

endclass
`endif
