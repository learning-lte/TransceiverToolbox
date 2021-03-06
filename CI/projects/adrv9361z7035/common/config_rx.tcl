# Disconnect the ADC PACK pins
delete_bd_objs [get_bd_nets util_ad9361_adc_fifo_dout_data_0]
delete_bd_objs [get_bd_nets util_ad9361_adc_fifo_dout_data_1]
delete_bd_objs [get_bd_nets util_ad9361_adc_fifo_dout_data_2]
delete_bd_objs [get_bd_nets util_ad9361_adc_fifo_dout_data_3]
delete_bd_objs [get_bd_nets util_ad9361_adc_fifo_dout_valid_0]

global dma_config
# Configure DMA
if {[info exists dma_config]} {
    if {$dma_config eq "Packetized"} {
        set_property -dict [list CONFIG.DMA_DATA_WIDTH_DEST {256} CONFIG.DMA_TYPE_SRC {1} CONFIG.MAX_BYTES_PER_BURST {32768}] [get_bd_cells axi_ad9361_adc_dma]
        connect_bd_net [get_bd_pins axi_ad9361_adc_dma/s_axis_aclk] [get_bd_pins util_ad9361_divclk/clk_out]
        connect_bd_net [get_bd_pins util_ad9361_adc_pack/packed_fifo_wr_data] [get_bd_pins axi_ad9361_adc_dma/s_axis_data]
        connect_bd_net [get_bd_pins axi_ad9361_adc_dma/s_axis_valid] [get_bd_pins util_ad9361_adc_pack/packed_fifo_wr_en]
    }
}
