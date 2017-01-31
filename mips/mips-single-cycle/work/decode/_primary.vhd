library verilog;
use verilog.vl_types.all;
entity decode is
    port(
        instr_dec_i     : in     vl_logic_vector(31 downto 0);
        sign_ext_i      : in     vl_logic;
        rt_dec_o        : out    vl_logic_vector(4 downto 0);
        rs_dec_o        : out    vl_logic_vector(4 downto 0);
        rd_dec_o        : out    vl_logic_vector(4 downto 0);
        op_dec_o        : out    vl_logic_vector(5 downto 0);
        funct_dec_o     : out    vl_logic_vector(5 downto 0);
        shamt_dec_o     : out    vl_logic_vector(5 downto 0);
        target_dec_o    : out    vl_logic_vector(25 downto 0);
        sign_imm_dec_o  : out    vl_logic_vector(31 downto 0);
        is_r_type_dec_o : out    vl_logic;
        is_i_type_dec_o : out    vl_logic;
        is_j_type_dec_o : out    vl_logic
    );
end decode;
