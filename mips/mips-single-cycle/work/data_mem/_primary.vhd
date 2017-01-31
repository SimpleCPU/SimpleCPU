library verilog;
use verilog.vl_types.all;
entity data_mem is
    generic(
        data_seg_begin  : integer := 8192;
        data_seg_size   : integer := 16384
    );
    port(
        clk             : in     vl_logic;
        addr_dmem_ram_i : in     vl_logic_vector(31 downto 0);
        wr_data_dmem_ram_i: in     vl_logic_vector(31 downto 0);
        wr_strb_dmem_ram_i: in     vl_logic_vector(0 to 3);
        wr_en_dmem_ram_i: in     vl_logic;
        read_data_dmem_ram_o: out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_seg_begin : constant is 1;
    attribute mti_svvh_generic_type of data_seg_size : constant is 1;
end data_mem;
