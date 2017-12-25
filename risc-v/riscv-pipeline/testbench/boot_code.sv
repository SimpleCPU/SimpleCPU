// Boot Code
// Set up all the system/arch registers correctly 
// Currently only initialises the arch registers

function void boot_code ();
    for (int i = 0; i < 32; i++)
    begin
        if ($test$plusargs("preload_arch_regs"))
            T1.R1.reg_file [i] = (i*32 + i%3);
        else
            T1.R1.reg_file [i] = 0;
    end
    for (int i = 0; i < 1024; i++)
    begin
        T1.BPRED.bpred[i] = 0;
        T1.BPRED.btb[i] = 0;
    end

endfunction
