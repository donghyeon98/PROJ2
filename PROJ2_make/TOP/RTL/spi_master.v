`timescale 1ns / 1ps

module spi_master #(
	parameter FPGA_CLK   = 100_000_000			,
	parameter SPI_CLK    = 1_000_000			,	
	parameter DATA_WIDTH = 8				,
	parameter DEPTH      = 16				,
	parameter CPOL       = 0				,
 	parameter CPHA	     = 0				,
	parameter LSB_FIRST  = 0				,
	parameter NUM_SS     = 1				,
	parameter CS_SETUP   = 1				,
	parameter CS_HOLD    = 1				,
	parameter FRAME_W    = 8				)	
(
	clk							,
	rst_n							,
	m_tx_data						,
	m_tx_valid                              		,
	m_tx_ready                              		,
	m_ss_sel                                		,
	m_frame_words                           		,
	m_rx_data                               		,
	m_rx_valid                              		,
	m_rx_ready                              		,
	m_busy                                  		,
	m_frame_wait                            		,
	m_tx_full                               		,
	m_tx_empty                              		,
	m_rx_full                               		,
	m_rx_empty                              		,
	m_overrun_err                           		,
	sclk                                    		,
	mosi                                    		,
	miso                                    		,	
	cs_n					
)									;
	localparam HALF_DIV = FPGA_CLK / (2 * SPI_CLK)			;
	localparam SS_W     = (NUM_SS > 1) ? $clog2(NUM_SS) : 1 	;

	input  clk                   				;
	input  rst_n                 				;
	input  [DATA_WIDTH-1:0] m_tx_data             		;
	input  m_tx_valid            				;
	output m_tx_ready            				;
	input  [SS_W-1:0] m_ss_sel              		;
	input  [FRAME_W-1:0] m_frame_words         		;
	output [DATA_WIDTH-1:0] m_rx_data             		;
	output m_rx_valid            				;
	input  m_rx_ready            				;
	output m_busy                				;
	output m_frame_wait          				;
	output m_tx_full             				;
	output m_tx_empty            				;
	output m_rx_full             				;
	output m_rx_empty            				;
	output m_overrun_err         				;
	output sclk                  				;
	output mosi                  				;
	input  miso                  				;
	output [NUM_SS-1:0] cs_n				;

	reg m_overrun_err						;
	reg sclk							;
	reg [NUM_SS-1:0] cs_n						;

	wire tx_rd_en						;
	wire [DATA_WIDTH-1:0] tx_rd_data			;
	wire rx_wr_en						;
	wire [DATA_WIDTH-1:0] rx_wr_data			;

	assign m_tx_ready = ~m_tx_full				;
	assign m_rx_valid = ~m_rx_empty				;

	Sync_FIFO #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) master_tx_fifo (
	.clk(clk)						,
	.rst_n(rst_n)						,
	.wr_en(m_tx_valid && m_tx_ready)			,
	.rd_en(tx_rd_en)					,
	.wr_data(m_tx_data)					,
	.rd_data(tx_rd_data)					,
	.full(m_tx_full)					,
	.empty(m_tx_empty)
	)							;

	Sync_FIFO #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) master_rx_fifo (
        .clk(clk)                                               ,
        .rst_n(rst_n)                                           ,
        .wr_en(rx_wr_en)                        		,
        .rd_en(m_rx_valid && m_rx_ready)                        ,
        .wr_data(rx_wr_data)                                    ,
        .rd_data(m_rx_data)                                  	,
        .full(m_rx_full)                                        ,
        .empty(m_rx_empty)
        )   							;

	reg [2:0] state						;
	reg [2:0] next_state					;

	localparam IDLE     = 3'b000 				;
	localparam LOAD     = 3'b001				;
	localparam SETUP    = 3'b010				;
	localparam TRANSFER = 3'b011				;
	localparam WAIT     = 3'b100				;
	localparam HOLD     = 3'b101				;
	localparam GAP      = 3'b110				;

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
			LOAD     :
			SETUP    :
			TRANSFER :
			WAIT     :
			HOLD     :
			GAP      :
			default  :			
		endcase
	end

	// Output logic / datapath (sequential)
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			sclk <= CPOL				;
			mosi <= 0				;
			cs_n <= 0				;
			
		end
		else begin
			case(state) 
				IDLE     :
                        	LOAD     :
                        	SETUP    :
                        	TRANSFER :
                        	WAIT     :
                        	HOLD     :
                        	GAP      :
                        	default  :
			endcase
		end
	end

endmodule
