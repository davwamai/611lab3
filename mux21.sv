module mux21 (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic        s,
    output logic [31:0] c
);

    assign c = (~s) ? a : b;

endmodule

