// instr RAM

module instr_mem
    (
        input   wire        clk,
        input   wire[31:0]  addr_imem_ram_i,
        input   wire[31:0]  wr_instr_imem_ram_i,
        input   wire        wr_en_imem_ram_i,
        output  wire[31:0]  read_instr_imem_ram_o
    );

    // 4K mem Byte Addressable
    reg [31:0] imem [2047:0];

    wire[31:0] read_instr;
    wire[31:0] shifted_read_addr;

    assign read_instr_imem_ram_o = read_instr;
    assign shifted_read_addr = (addr_imem_ram_i & 32'hFFFF_FFFC)>>2;

    always @(posedge clk)
    if (wr_en_imem_ram_i)
        imem[shifted_read_addr] <= wr_instr_imem_ram_i;

    assign read_instr = imem[shifted_read_addr];

endmodule
