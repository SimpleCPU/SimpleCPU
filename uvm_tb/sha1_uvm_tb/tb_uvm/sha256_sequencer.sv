// SHA-256 Sequencer
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "sha256_transaction.sv"

typedef uvm_sequencer # (sha256_transaction) sha256_sequencer;
