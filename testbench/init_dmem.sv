// Memory initialisation

function void init_dmem ();
    for (int i = 0; i < 200; i=i+4)
    begin
        T1.D_MEM1.dmem [i] = i/4;
    end

endfunction
