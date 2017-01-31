library verilog;
use verilog.vl_types.all;
entity pc_reg is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        next_pc_pc_reg_i: in     vl_logic_vector(31 downto 0);
        next_pc_pc_reg_o: out    vl_logic_vector(31 downto 0)
    );
end pc_reg;
