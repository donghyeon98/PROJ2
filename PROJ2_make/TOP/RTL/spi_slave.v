`timescale 1ns / 1ps

module spi_slave #(
	parameter DATA_WIDTH = 8                	,
	parameter DEPTH      = 16               	,
	parameter CPOL       = 0                	,
	parameter CPHA       = 0                	,
	parameter LSB_FIRST  = 0                	,
	parameter TX_DEFAULT = 0                	,
	parameter DAISY_EN   = 0                	)
(
	clk                                     	,
	rst_n                                   	,
	s_tx_data                               	,
	s_tx_valid                              	,
	s_tx_ready                              	,
	s_rx_data                               	,
	s_rx_valid                              	,
	s_rx_ready                              	,
	s_busy                                  	,
	s_tx_full                               	,
	s_tx_empty                              	,
	s_rx_full                               	,
	s_rx_empty                              	,
	s_overrun_err                           	,
	s_underrun_err                          	,
	s_frame_err                             	,
	s_sclk_i                                	,
	s_mosi_i                                	,
	s_cs_n_i                                	,
	s_miso_o                                	,
	s_miso_oe                                
)							;

	input                     clk                   ;
	input                     rst_n                 ;
	input   [DATA_WIDTH-1:0]  s_tx_data             ;
	input                     s_tx_valid            ;
	output                    s_tx_ready            ;
	output  [DATA_WIDTH-1:0]  s_rx_data             ;
	output                    s_rx_valid            ;
	input                     s_rx_ready            ;
	output                    s_busy                ;
	output                    s_tx_full             ;
	output                    s_tx_empty            ;
	output                    s_rx_full             ;
	output                    s_rx_empty            ;
	output                    s_overrun_err         ;
	output                    s_underrun_err        ;
	output                    s_frame_err           ;
	input                     s_sclk_i              ;
	input                     s_mosi_i              ;
	input                     s_cs_n_i              ;
	output                    s_miso_o              ;
	output                    s_miso_oe             ;


	assign s_tx_ready = ~s_tx_full                          ;
        assign s_rx_valid = ~s_rx_empty                         ;

        Sync_FIFO #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) slave_tx_fifo (
        .clk(clk)                                               ,
        .rst_n(rst_n)                                           ,
        .wr_en(s_tx_valid && s_tx_ready)                        ,
        .rd_en(tx_rd_en)                                        ,
        .wr_data(s_tx_data)                                     ,
        .rd_data(tx_rd_data)                                    ,
        .full(s_tx_full)                                        ,
        .empty(s_tx_empty)
        )                                                       ;

        Sync_FIFO #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) slave_rx_fifo (
        .clk(clk)                                               ,
        .rst_n(rst_n)                                           ,
        .wr_en(rx_wr_en)                                        ,
        .rd_en(s_rx_valid && s_rx_ready)                        ,
        .wr_data(rx_wr_data)                                    ,
        .rd_data(s_rx_data)                                     ,
        .full(s_rx_full)                                        ,
        .empty(s_rx_empty)
        )                                                       ;



	reg [1:0] state 					;
	reg [1:0] next_state					;

	localparam IDLE     = 2'b00				;
	localparam PREFETCH = 2'b01				;
	localparam READY    = 2'b10				;
	localparam XFER     = 2'b11				;


	// State register (sequential)
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) state <= IDLE			;
		else       state <= next_state			;
        end

	// Next state logic (combinational)
        always@(*) begin
		next_state = state				;
		case(state)
			IDLE     :
			PREFETCH :
			READY	 :
			XFER     :
			default  : next_state = IDLE		;
		endcase	
        end

	// Output logic / datapath (sequential)
        always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			s_miso_o       <= 0			;
			s_miso_oe      <= DASIY_EN  ? 1 :0	;
			s_busy         <= 0			;
			s_overrun_err  <= 0			;
			s_underrun_err <= 0			;
			s_frame_err    <= 0			;
		end
		else begin
			case(state)
                        IDLE     :
                        PREFETCH :
                        READY    :
                        XFER     :
                        default  :            			;
                endcase

		end
        end

endmodule
