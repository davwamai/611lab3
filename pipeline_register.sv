module pipeline_register #(parameter WIDTH = 32) (
    input logic [WIDTH-1:0] in,
    input logic clk,
    output logic [WIDTH-1:0] out
);
    always_ff @(posedge clk) begin
        out <= in;
    end
endmodule