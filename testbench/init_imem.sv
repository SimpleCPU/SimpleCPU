// Memory initialisation

function void init_imem ();
    T1.I_MEM1.imem [0] = 32'h8C0000C0;
    T1.I_MEM1.imem [4] = 32'h8C0000C0;
    T1.I_MEM1.imem [8] = 32'h20000022;
    T1.I_MEM1.imem [12] = 32'h30000033;
    T1.I_MEM1.imem [16] = 32'h40000044;
    T1.I_MEM1.imem [20] = 32'h50000055;
    T1.I_MEM1.imem [24] = 32'h60000066;
    T1.I_MEM1.imem [28] = 32'h70000077;
    T1.I_MEM1.imem [32] = 32'h80000088;
    T1.I_MEM1.imem [36] = 32'h90000099;

endfunction
