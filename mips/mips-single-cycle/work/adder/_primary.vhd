library verilog;
use verilog.vl_types.all;
entity adder is
    port(
        op1             : in     vl_logic_vector(31 downto 0);
        op2             : in     vl_logic_vector(31 downto 0);
        cin             : in     vl_logic;
        sum             : out    vl_logic_vector(31 downto 0);
        carry           : out    vl_logic
    );
end adder;
