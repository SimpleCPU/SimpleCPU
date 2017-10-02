// Memory initialisation

function void init_imem (string test_name);
    logic [31:0] instr_hex [2047:0];
    logic [31:0] pc_val [2047:0];
    
    parameter instr_seg_begin = 32'h2000,
              instr_seg_size  = 32'h1FFF;

    string instr_hex_s;
    string pc_values_hex_s;
    
    instr_hex_s     = {test_name, ".hex"};
    pc_values_hex_s = {test_name, "_pc.hex"};
    

    $readmemh (instr_hex_s, instr_hex, 0);
    $readmemh (pc_values_hex_s, pc_val, 0);

    for (int i = 0; instr_hex[i]; i++) 
    begin
        //$display ("Loading %x at %x\n", instr_hex[i], pc_val[i]);
        T1.I_MEM1.imem [(pc_val[i]-instr_seg_begin)>>2] = instr_hex[i];
    end

endfunction
