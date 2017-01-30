library verilog;
use verilog.vl_types.all;
entity control is
    port(
        instr_op_ctl_i  : in     vl_logic_vector(5 downto 0);
        instr_funct_ctl_i: in     vl_logic_vector(5 downto 0);
        reg_src_ctl_o   : out    vl_logic;
        reg_dst_ctl_o   : out    vl_logic;
        jump_ctl_o      : out    vl_logic;
        branch_ctl_o    : out    vl_logic;
        mem_read_ctl_o  : out    vl_logic;
        mem_to_reg_ctl_o: out    vl_logic;
        alu_op_ctl_o    : out    vl_logic_vector(5 downto 0);
        mem_wr_ctl_o    : out    vl_logic;
        alu_src_ctl_o   : out    vl_logic_vector(1 downto 0);
        reg_wr_ctl_o    : out    vl_logic;
        sign_ext_ctl_o  : out    vl_logic
    );
end control;
