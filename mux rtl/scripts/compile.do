exec rm -rf mti_work
vlib mti_work
vmap work mti_work
vcom rtl/and2.vhd
vcom rtl/or2.vhd
vcom rtl/inv.vhd
vcom rtl/mux2_1.vhd
vcom rtl/mux2_multibit.vhd
vcom rtl/tb_mux2_multibit.vhd
quit
