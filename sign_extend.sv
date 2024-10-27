module sign_extend (input logic [11:0] in, output logic [31:0] out);
    assign out = {{20{in[11]}}, in};
endmodule
