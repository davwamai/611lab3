module controlunit (
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    input logic [11:0] csr,

    output logic alusrc_EX,
    output logic GPIO_we,
    output logic regwrite_EX,
    output logic [1:0] regsel_EX,
    output logic [3:0] aluop_EX
);

localparam OPCODE_R_TYPE = 7'h33;
localparam OPCODE_I_TYPE = 7'h13;
localparam OPCODE_U_TYPE = 7'h37;
localparam OPCODE_CSRRW = 7'h73;

    always_comb begin
        // default values for out signals
        aluop_EX     = 4'b0000;
        alusrc_EX    = 1'b0;
        regsel_EX    = 2'b00;
        regwrite_EX  = 1'b0;
        GPIO_we   = 1'b0;

        // based on opcode, funct3, funct7, etc.
        case (opcode)
            OPCODE_R_TYPE: begin // R-type instructions
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'h0) begin
                            aluop_EX    = 4'b0011; // ALU operation for ADD
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we     = 1'b0;
                        end
                        if (funct7 == 7'h20) begin
                            aluop_EX    = 4'b0100; // ALU operation for SUB
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                        if (funct7 == 7'h1) begin
                            aluop_EX    = 4'b0101; // ALU operation for MUL
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                    end
                    3'b010: begin
                        if (funct7 == 7'h0) begin
                            aluop_EX    = 4'b1100; // ALU operation for SLT
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                    end
                    3'b011: begin
                        if (funct7 == 7'h0) begin
                            aluop_EX    = 4'b1101; // ALU operation for SLTU
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                        if (funct7 == 7'h1) begin
                            aluop_EX    = 4'b0111; // ALU operation for MULHU
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                    end
                    3'b111: begin // AND
                        if (funct7 == 7'h0) begin
                            aluop_EX    = 4'b0000; // ALU operation for AND
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                    end
                    3'b110: begin // OR
                        if (funct7 == 7'h0) begin
                            aluop_EX    = 4'b0001; // ALU operation for OR
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                    end
                    3'b100: begin // XOR
                        if (funct7 == 7'h0) begin
                            aluop_EX    = 4'b0010; // ALU operation for XOR
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                    end
                    3'b101: begin // SRL, SRA
                        case (funct7)
                            7'h00: begin // SRL
                                aluop_EX    = 4'b1001; // ALU operation for SRL
                                alusrc_EX   = 1'b0;
                                regsel_EX   = 2'b10;
                                regwrite_EX = 1'b1;
                                GPIO_we  = 1'b0;
                            end
                            7'h20: begin // SRA
                                aluop_EX    = 4'b1010; // ALU operation for SRA
                                alusrc_EX   = 1'b0;
                                regsel_EX   = 2'b10;
                                regwrite_EX = 1'b1;
                                GPIO_we  = 1'b0;
                            end
                        endcase
                    end
                    3'b001: begin
                        if (funct7 == 7'h0) begin
                            aluop_EX    = 4'b1000; // ALU operation for SLL
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                        if (funct7 == 7'h1) begin
                            aluop_EX    = 4'b0110; // ALU operation for MULH
                            alusrc_EX   = 1'b0;
                            regsel_EX   = 2'b10;
                            regwrite_EX = 1'b1;
                            GPIO_we  = 1'b0;
                        end
                    end
                endcase
            end

            OPCODE_I_TYPE: begin // I-type instructions
                case (funct3)
                    3'b000: begin // ADDI
                        aluop_EX    = 4'b0011; // ALU operation for ADDI
                        alusrc_EX   = 1'b1;    // Immediate source for ALU
                        regsel_EX   = 2'b10;
                        regwrite_EX = 1'b1;
                        GPIO_we  = 1'b0;
                    end
                    3'b111: begin // ANDI
                        aluop_EX    = 4'b0000; // ALU operation for ANDI
                        alusrc_EX   = 1'b1;    // Immediate source for ALU
                        regsel_EX   = 2'b10;
                        regwrite_EX = 1'b1;
                        GPIO_we  = 1'b0;
                    end
                    3'b001: begin // SLLI
                        aluop_EX    = 4'b1000; // ALU operation for SLLI
                        alusrc_EX   = 1'b1;    // Immediate source for ALU
                        regsel_EX   = 2'b10;
                        regwrite_EX = 1'b1;
                        GPIO_we  = 1'b0;
                    end
                    3'b110: begin // ORI
                        aluop_EX    = 4'b0001; // ALU operation for ORI
                        alusrc_EX   = 1'b1;    // Immediate source for ALU
                        regsel_EX   = 2'b10;
                        regwrite_EX = 1'b1;
                        GPIO_we  = 1'b0;
                    end
                    3'b100: begin // XORI
                        aluop_EX    = 4'b0010; // ALU operation for XORI
                        alusrc_EX   = 1'b1;    // Immediate source for ALU
                        regsel_EX   = 2'b10;
                        regwrite_EX = 1'b1;
                        GPIO_we  = 1'b0;
                    end
                    3'b101: begin // SRLI, SRAI
                        case (funct7)
                            7'h00: begin // SRLI
                                aluop_EX    = 4'b1001; // ALU operation for SRLI
                                alusrc_EX   = 1'b1;    // Immediate source for ALU
                                regsel_EX   = 2'b10;
                                regwrite_EX = 1'b1;
                                GPIO_we  = 1'b0;
                            end
                            7'h20: begin // SRAI
                                aluop_EX    = 4'b1010; // ALU operation for SRAI
                                alusrc_EX   = 1'b1;    // Immediate source for ALU
                                regsel_EX   = 2'b10;
                                regwrite_EX = 1'b1;
                                GPIO_we  = 1'b0;
                            end
                        endcase
                    end
                endcase
            end

            OPCODE_CSRRW: begin // CSRRW instructions
                case (csr)
                    12'hf02: begin // HEX displays (io2)
                        aluop_EX    = 4'bX;
                        alusrc_EX   = 1'bX;
                        regsel_EX   = 2'bX;
                        regwrite_EX = 1'b0;
                        GPIO_we  = 1'b1;
                    end
                    12'hf00: begin // switches (io0)
                        aluop_EX    = 4'bX;
                        alusrc_EX   = 1'bX;
                        regsel_EX   = 2'b00;
                        regwrite_EX = 1'b1;
                        GPIO_we  = 1'b0;
                    end
                endcase
            end
            OPCODE_U_TYPE: begin // lui
                aluop_EX    = 4'bX;
                alusrc_EX   = 1'bX;
                regsel_EX   = 2'b01;
                regwrite_EX = 1'b1;
                GPIO_we  = 1'b0;
            end
        endcase
    end
endmodule
