// Data RAM

module data_mem
    (
        input   wire        clk,
        input   wire[31:0]  addr_dmem_ram_i,
        input   wire[31:0]  wr_data_dmem_ram_i,
        input   wire        wr_en_dmem_ram_i,
        output  wire[31:0]  read_data_dmem_ram_o
    );

    // 4K mem Byte Addressable
    reg [31:0] dmem [1023:0];

    wire[31:0] read_data;

    assign read_data_dmem_ram_o = read_data;

    always @(posedge clk)
    if (wr_en_dmem_ram_i)
        dmem[addr_dmem_ram_i << 1] <= wr_data_dmem_ram_i;

    assign read_data = dmem[addr_dmem_ram_i << 1];

endmodule
