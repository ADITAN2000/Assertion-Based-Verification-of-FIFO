`timescale 1ns/1ps

module tb_fifo;

  // Parameters
  localparam WIDTH = 8;
  localparam DEPTH = 16;

  // DUT signals
  logic clk, rst;
  logic wr_en, rd_en;
  logic [WIDTH-1:0] din;
  logic [WIDTH-1:0] dout;
  logic full, empty;

  // DUT instantiation
  fifo_sync dut (
    .clk   (clk),
    .reset (rst),   // 
    .wr_en (wr_en),
    .rd_en (rd_en),
    .din   (din),
    .dout  (dout),
    .full  (full),
    .empty (empty)
  );

  // Clock
  initial clk = 0;
  always #5 clk = ~clk; // 100 MHz clock

  // Stimulus
  initial begin
    // Initialize
    rst   = 1;
    wr_en = 0;
    rd_en = 0;
    din   = 0;
    #20;
    rst = 0;

    // Try writing beyond depth
    repeat (20) begin
      @(posedge clk);
      wr_en = 1;
      din = $random;
    end
    @(posedge clk) wr_en = 0;

    // Try reading beyond depth
    repeat (20) begin
      @(posedge clk);
      rd_en = 1;
    end
    @(posedge clk) rd_en = 0;

    #50;
    $finish;
  end

  // ============================================================
  // Assertions (don't rely on internal DUT signals)
  // ============================================================

  // 1. No write allowed when FIFO is full
  property no_write_when_full;
    @(posedge clk) disable iff (rst)
      !(wr_en && full);
  endproperty
  assert property(no_write_when_full)
    else $error("Assertion Failed: Write attempted when FIFO FULL at %0t", $time);

  // 2. No read allowed when FIFO is empty
  property no_read_when_empty;
    @(posedge clk) disable iff (rst)
      !(rd_en && empty);
  endproperty
  assert property(no_read_when_empty)
    else $error("Assertion Failed: Read attempted when FIFO EMPTY at %0t", $time);

  // 3. Full and Empty cannot be high together
  property not_full_and_empty;
    @(posedge clk) disable iff (rst)
      !(full && empty);
  endproperty
  assert property(not_full_and_empty)
    else $error("Assertion Failed: FIFO FULL and EMPTY both HIGH at %0t", $time);

endmodule
