library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        opr_a_alu_i     : in     vl_logic_vector(31 downto 0);
        opr_b_alu_i     : in     vl_logic_vector(31 downto 0);
        op_alu_i        : in     vl_logic_vector(5 downto 0);
        res_alu_o       : out    vl_logic_vector(31 downto 0);
        z_alu_o         : out    vl_logic;
        n_alu_o         : out    vl_logic
    );
end alu;
