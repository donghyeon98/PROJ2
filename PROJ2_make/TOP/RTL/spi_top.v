`timescale 1ns / 1ps 

module spi_top #(
	parameter FPGA_CLK   = 100_000_000      ,
	parameter SPI_CLK    = 1_000_000        ,
	parameter DATA_WIDTH = 8                ,
	parameter DEPTH      = 16               ,
	parameter CPOL       = 0                ,
	parameter CPHA       = 0                ,
	parameter LSB_FIRST  = 0                ,
	parameter NUM_SS     = 1                ,
	parameter CS_SETUP   = 1                ,
	parameter CS_HOLD    = 1                ,
	parameter TX_DEFAULT = 0                ,
	parameter DAISY_EN   = 0                ,
	parameter FRAME_W    = 8                )
(
	clk                                     ,
	rst_n                                   ,
	loop_en                                 ,
	m_tx_data                               ,
	m_tx_valid                              ,
	m_tx_ready                              ,
	m_ss_sel                                ,
	m_frame_words                           ,
	m_rx_data                               ,
	m_rx_valid                              ,
	m_rx_ready                              ,
	m_busy                                  ,
	m_frame_wait                            ,
	m_tx_full                               ,
	m_tx_empty                              ,
	m_rx_full                               ,
	m_rx_empty                              ,
	m_overrun_err                           ,
	sclk                                    ,
	mosi                                    ,
	miso                                    ,
	cs_n                                    ,
	s_tx_data                               ,
	s_tx_valid                              ,
	s_tx_ready                              ,
	s_rx_data                               ,
	s_rx_valid                              ,
	s_rx_ready                              ,
	s_busy                                  ,
	s_tx_full                               ,
	s_tx_empty                              ,
	s_rx_full                               ,
	s_rx_empty                              ,
	s_overrun_err                           ,
	s_underrun_err                          	  ,
	s_frame_err                             	  ,
	s_sclk_i                                	  ,
	s_mosi_i                                	  ,
	s_cs_n_i                                	  ,
	s_miso_o                                	  ,
	s_miso_oe                                
)							  ;

	input                     clk                     ;
	input                     rst_n                   ;
	input                     loop_en                 ;
	input   [DATA_WIDTH-1:0]  m_tx_data               ;
	input                     m_tx_valid              ;
	output                    m_tx_ready              ;
	input   [SS_W-1:0]        m_ss_sel                ;
	input   [FRAME_W-1:0]     m_frame_words           ;
	output  [DATA_WIDTH-1:0]  m_rx_data               ;
	output                    m_rx_valid              ;
	input                     m_rx_ready              ;
	output                    m_busy                  ;
	output                    m_frame_wait            ;
	output                    m_tx_full               ;
	output                    m_tx_empty              ;
	output                    m_rx_full               ;
	output                    m_rx_empty              ;
	output                    m_overrun_err           ;
	output                    sclk                    ;
	output                    mosi                    ;
	input                     miso                    ;
	output  [NUM_SS-1:0]      cs_n                    ;
	input   [DATA_WIDTH-1:0]  s_tx_data               ;
	input                     s_tx_valid              ;
	output                    s_tx_ready              ;
	output  [DATA_WIDTH-1:0]  s_rx_data               ;
	output                    s_rx_valid              ;
	input                     s_rx_ready              ;
	output                    s_busy                  ;
	output                    s_tx_full               ;
	output                    s_tx_empty              ;
	output                    s_rx_full               ;
	output                    s_rx_empty              ;
	output                    s_overrun_err           ;
	output                    s_underrun_err          ;
	output                    s_frame_err             ;
	input                     s_sclk_i                ;
	input                     s_mosi_i                ;
	input                     s_cs_n_i                ;
	output                    s_miso_o                ;
	output                    s_miso_oe               ;

	spi_master master();

	spi_slave slave();





endmodule
