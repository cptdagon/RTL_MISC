
exec rm -rf mti_work 
vlib mti_work
vmap work mti_work
vcom rtl/param_reg.vhd
vcom rtl/dff.vhd
vcom rtl/cnt1_package.vhd
vcom rtl/bram_param.vhd
vcom rtl/ram_piped.vhd
vcom rtl/fsm.vhd
vcom rtl/memory_controller.vhd
vcom rtl/tb_fsm.vhd
exit
