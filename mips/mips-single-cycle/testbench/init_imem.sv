// Memory initialisation

function void init_imem ();
    logic [31:0] instr_hex [1023:0];
    logic [31:0] pc_val [2048:0];
    
    $readmemh ("instr_hex", instr_hex, 0, 999);
    $readmemh ("pc_values_hex", pc_val, 0, 999);
    
    for (int i = 0; instr_hex[i]; i++) 
    begin
        //$display ("Loading %x at %x\n", instr_hex[i], pc_val[i]);
        T1.I_MEM1.imem [pc_val[i]>>2] = instr_hex[i];
    end

endfunction
