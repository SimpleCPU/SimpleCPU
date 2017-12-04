`ifndef SHA256_GENERATOR_SV
`define SHA256_GENERATOR_SV
// The SHA256 Message Generator 
// This class generates the message load for the hash computation

class sha256_generator;
    
    // Define the message length as a random property
    rand longint        msg_len;
    // Define the message as a random property
    rand bit [2**20:0]  message;

    // Define the constraints on message length
    // The following constraints are valid:
    //      - Length can be between 0-2^20-1
    //      - Should be a multiple of 8 as
    //        the message will be an ascii
    constraint msg_len_c {
    };

    // Define the constraints on the message
    // The following constraints are valid:
    //      - Message can be between 0-2^20-1
    //      - Should represent valid ascii
    constraint message_c {
    };

endclass
`endif
