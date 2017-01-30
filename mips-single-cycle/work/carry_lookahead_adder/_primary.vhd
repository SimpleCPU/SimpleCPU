library verilog;
use verilog.vl_types.all;
entity carry_lookahead_adder is
    port(
        op1             : in     vl_logic_vector(3 downto 0);
        op2             : in     vl_logic_vector(3 downto 0);
        cin             : in     vl_logic;
        s               : out    vl_logic_vector(3 downto 0);
        cout            : out    vl_logic
    );
end carry_lookahead_adder;
