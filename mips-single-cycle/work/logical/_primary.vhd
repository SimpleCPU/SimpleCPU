library verilog;
use verilog.vl_types.all;
entity logical is
    port(
        op1             : in     vl_logic_vector(31 downto 0);
        op2             : in     vl_logic_vector(31 downto 0);
        operation       : in     vl_logic_vector(2 downto 0);
        res             : out    vl_logic_vector(31 downto 0)
    );
end logical;
