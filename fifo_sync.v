// Synchronous FIFO (8-bit wide, 16-depth)
module fifo_sync (
    input        clk,      // Clock
    input        reset,    // Active-high reset
    input        wr_en,    // Write enable
    input        rd_en,    // Read enable
    input  [7:0] din,      // Data input
    output reg [7:0] dout, // Data output
    output       full,     // FIFO full flag
    output       empty     // FIFO empty flag
);

    // Internal memory (16 x 8-bit)
    reg [7:0] mem [0:15];

    // Write and Read pointers (5 bits: 4 for index + 1 MSB for wrap)
    reg [4:0] w_ptr, r_ptr;

    // ---------------------------
    // Write Logic
    // ---------------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_ptr <= 5'b0;
        end
        else if (wr_en && !full) begin
            mem[w_ptr[3:0]] <= din;
            w_ptr <= w_ptr + 1'b1;
        end
    end

    // ---------------------------
    // Read Logic
    // ---------------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_ptr <= 5'b0;
            dout  <= 8'b0;
        end
        else if (rd_en && !empty) begin
            dout <= mem[r_ptr[3:0]];
            r_ptr <= r_ptr + 1'b1;
        end
    end

    // ---------------------------
    // FIFO Status Flags
    // ---------------------------
    assign empty = (w_ptr == r_ptr);

    assign full  = (w_ptr[3:0] == r_ptr[3:0]) &&
                   (w_ptr[4]   != r_ptr[4]);

endmodule
