// Memory initialisation

function void init_imem ();
    logic [31:0] instr_hex [1023:0];
    logic [31:0] pc_val [1023:0];
    
    $readmemh ("instr_hex", instr_hex, 0, 999);
    
    for (int i = 0; i < 999; i++) 
    begin
        T1.I_MEM1.imem [i] = instr_hex[i];
    end

endfunction
