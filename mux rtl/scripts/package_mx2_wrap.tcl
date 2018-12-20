#-----------------------------------------------------------
# Vivado v2013.4 (64-bit)
# SW Build 353583 on Mon Dec  9 17:26:26 MST 2013
# IP Build 208076 on Mon Dec  2 12:38:17 MST 2013
# Start of session at: Thu Jan 23 12:09:11 2014
# Process ID: 8901
# Log file: /home/elvc/work/projects/elements/vivado.log
# Journal file: /home/elvc/work/projects/elements/vivado.jou
#-----------------------------------------------------------
create_project -force mx2_wrap mx2_wrap -part xc7z020clg484-1
set_property board xilinx.com:zynq:zc706:1.1 [current_project]
set_property target_language VHDL [current_project]
add_files -norecurse rtl/mx2_wrap.vhd
add_files -norecurse rtl/mux2_multibit.vhd
add_files -norecurse rtl/mux2_1.vhd
add_files -norecurse rtl/inv.vhd
add_files -norecurse rtl/or2.vhd
add_files -norecurse rtl/and2.vhd

#add_files -norecurse /home/elvc/work/projects/elements/rtl/functions_pkg.vhd
#add_files -norecurse /home/elvc/work/projects/elements/rtl/axi4_dma.vhd
set_property library {work} [get_files { rtl/mx2_wrap.vhd rtl/mux2_multibit.vhd rtl/mux2_1.vhd rtl/inv.vhd rtl/or2.vhd rtl/and2.vhd } ]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
ipx::package_project -root_dir {mx2_wrap}
set_property vendor {vac} [ipx::current_core]
set_property library {elements} [ipx::current_core]
set_property vendor_display_name {vac} [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property ip_repo_paths  mx2_wrap [current_fileset]
update_ip_catalog
exit
