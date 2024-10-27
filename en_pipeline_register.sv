module en_pipeline_register #(parameter WIDTH = 32) (
    input logic [WIDTH-1:0] in,
    input logic clk,
    input logic en,
    output logic [WIDTH-1:0] out
);
    always_ff @(posedge clk) begin
      if (en) begin
          out <= in;
      end
    end
endmodule
