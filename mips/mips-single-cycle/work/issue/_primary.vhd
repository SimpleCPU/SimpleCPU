library verilog;
use verilog.vl_types.all;
entity issue is
    port(
        rs_iss_i        : in     vl_logic_vector(5 downto 0);
        rt_iss_i        : in     vl_logic_vector(5 downto 0);
        rd_iss_i        : in     vl_logic_vector(5 downto 0);
        imm_iss_i       : in     vl_logic_vector(15 downto 0);
        rd_reg1_iss_o   : out    vl_logic_vector(5 downto 0);
        rd_reg2_iss_o   : out    vl_logic_vector(5 downto 0);
        wr_reg_iss_o    : out    vl_logic_vector(5 downto 0);
        sign_imm_iss_o  : out    vl_logic_vector(31 downto 0)
    );
end issue;
