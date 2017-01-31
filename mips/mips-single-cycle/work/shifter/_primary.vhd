library verilog;
use verilog.vl_types.all;
entity shifter is
    port(
        op1             : in     vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(5 downto 0);
        operation       : in     vl_logic_vector(1 downto 0);
        res             : out    vl_logic_vector(31 downto 0)
    );
end shifter;
