# -timescale : To mention the time unit and time precision
# # -access : Passed to the elaborator to provide read access to simulation objects
# # -gui : To invoke the xrun in gui mode
# # -mess : To display all to the messages in detail
# # -define : To provide SDF definition present in the testbench file
# # -v : To provide library in ".v" format
# # +libext : library extention
# # +libext+.v -y : xrun would compile .v files automatically in the specific folder decribed with -y option


xrun 	-64bit	\
	+max_err_count+50 \
	+define+function_sim \
	-access +rwc \
	-profile \
	-profthread \
	+libext+.v \
	../TESTBENCH/tb_uart_top.v \
	../../RTL/Sync_FIFO.v \
        ../../RTL/baud_rate_gen.v \
        ../../RTL/uart_tx.v \
        ../../RTL/uart_rx.v \
        ../../RTL/uart_top.v \
	/GPDK045/digital/giolib045_v3.5/vlog/pads_FF_s1vg.v \
        /GPDK045/digital/gsclib045_all_v4.4/gsclib045_svt_v4.4/gsclib045/verilog/slow_vdd1v0_basicCells.v \
	-l func_sim.log	
