library verilog;
use verilog.vl_types.all;
entity carry_lookahead_gen is
    port(
        g               : in     vl_logic_vector(3 downto 0);
        p               : in     vl_logic_vector(3 downto 0);
        cin             : in     vl_logic;
        cout            : out    vl_logic_vector(3 downto 0)
    );
end carry_lookahead_gen;
