// Data RAM

module data_mem
    (
        input   wire        clk,
        input   wire[31:0]  addr_dmem_ram_i,
        input   wire[31:0]  wr_data_dmem_ram_i,
        input   wire[0:3]   wr_strb_dmem_ram_i,
        input   wire        wr_en_dmem_ram_i,
        output  wire[31:0]  read_data_dmem_ram_o
    );

    parameter data_seg_begin = 32'h0,
              data_seg_size  = 32'h1FFF;
    // Byte Addressable mem
    reg [31:0] dmem [0:data_seg_size];

    wire[31:0] read_data;
    wire[31:0] wr_strb = {wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],
                          wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],  
                          wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2], 
                          wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2], 
                          wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1], 
                          wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1], 
                          wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0], 
                          wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0]}; 

    assign read_data_dmem_ram_o = read_data;

    always @(posedge clk)
    if (wr_en_dmem_ram_i)
        dmem[((addr_dmem_ram_i - data_seg_begin)&(~32'h3))>>2] <= ((wr_data_dmem_ram_i & wr_strb) | (~wr_strb & read_data));

    assign read_data = dmem[((addr_dmem_ram_i - data_seg_begin)&(~32'h3))>>2];

endmodule
