`ifndef SHA256_GENERATOR_SV
`define SHA256_GENERATOR_SV
// The SHA256 Message Generator 
// This class generates the message load for the hash computation

class sha256_generator;
    
    // Define the message length as a random property
    rand longint        msg_len;
    // Define the message as a random property
    bit [2**20:0]       message;
    string              msg_string;

    rand logic [7:0]    ascii_char;

    // Define the constraints on message length
    // The following constraints are valid:
    //      - Length can be between 0-2^20-1
    //      - Should be a multiple of 8 as
    //        the message will be an ascii
    constraint msg_len_c {
        msg_len > 0;
        msg_len < 1024;
        msg_len % 8 == 0;
    }

    // Function to generate the ascii message
    // Generates message containing english
    // alphabets.
    function void generate_msg ();
        $display ("Message Len is: %3d", this.msg_len);
        for (int i=0; i < msg_len/8; i++) begin
            // Randomly pick either capitals or small
            if (($random%2)) begin
              if (randomize (ascii_char) with {
                    ascii_char > 64;
                    ascii_char < 91;
              }) begin
                  if (i) begin
                    message     = {message, ascii_char};
                    msg_string  = {msg_string, ascii_char};
                  end
                  else begin
                    message     = {ascii_char};
                    msg_string  = {ascii_char};
                  end
                  //$display ("Appending %2x", ascii_char);
              end
              else
                  $fatal (1, "Randomiztion failed during message generation");
            end
            else begin
              if (randomize (ascii_char) with {
                    ascii_char > 96;
                    ascii_char < 123;
              }) begin
                  if (i) begin
                    message     = {message, ascii_char};
                    msg_string  = {msg_string, ascii_char};
                  end
                  else begin
                    message     = ascii_char;
                    msg_string  = '{ascii_char};
                  end
                  //$display ("Appending %2x", ascii_char);
              end
              else
                  $fatal (1, "Randomiztion failed during message generation");
            end
        end
        $display ("Message is %s", msg_string);

    endfunction

endclass
//module test_class ();
//    
//    sha256_generator sha;
//    initial
//    begin
//        sha = new();
//        void'(sha.randomize());
//        sha.generate_msg();
//        $finish  (1);
//    end
//endmodule
`endif
