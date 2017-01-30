library verilog;
use verilog.vl_types.all;
entity reduced_full_adder is
    port(
        op1             : in     vl_logic;
        op2             : in     vl_logic;
        cin             : in     vl_logic;
        g               : out    vl_logic;
        p               : out    vl_logic;
        s               : out    vl_logic
    );
end reduced_full_adder;
