exec rm -rf  mti_work 
vlib mti_work
vmap work mti_work
vcom rtl/param_reg.vhd
vcom rtl/cnt1_package.vhd
vcom rtl/cnt1.vhd
vcom rtl/tb_cnt1.vhd
exit
