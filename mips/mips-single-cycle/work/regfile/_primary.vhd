library verilog;
use verilog.vl_types.all;
entity regfile is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        w_en_rf_i       : in     vl_logic;
        w_data_rf_i     : in     vl_logic_vector(31 downto 0);
        w_reg_rf_i      : in     vl_logic_vector(4 downto 0);
        r_reg_p1_rf_i   : in     vl_logic_vector(4 downto 0);
        r_reg_p2_rf_i   : in     vl_logic_vector(4 downto 0);
        r_data_p1_rf_o  : out    vl_logic_vector(31 downto 0);
        r_data_p2_rf_o  : out    vl_logic_vector(31 downto 0)
    );
end regfile;
