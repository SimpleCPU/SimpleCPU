library verilog;
use verilog.vl_types.all;
entity instr_mem is
    port(
        clk             : in     vl_logic;
        addr_imem_ram_i : in     vl_logic_vector(31 downto 0);
        wr_instr_imem_ram_i: in     vl_logic_vector(31 downto 0);
        wr_en_imem_ram_i: in     vl_logic;
        read_instr_imem_ram_o: out    vl_logic_vector(31 downto 0)
    );
end instr_mem;
