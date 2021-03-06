#-----------------------------------------------------------
# Vivado v2013.4 (64-bit)
# SW Build 353583 on Mon Dec  9 17:26:26 MST 2013
# IP Build 208076 on Mon Dec  2 12:38:17 MST 2013
# Start of session at: Thu Jan 23 12:09:11 2014
# Process ID: 8901
# Log file: /home/elvc/work/projects/elements/vivado.log
# Journal file: /home/elvc/work/projects/elements/vivado.jou
#-----------------------------------------------------------
create_project -force axi4lite_slave_regsif axi4lite_slave_regsif -part xc7z020clg484-1
set_property board xilinx.com:zynq:zc706:1.1 [current_project]
set_property target_language VHDL [current_project]
add_files -norecurse rtl/axi4lite_slave_regsif.vhd
set_property library {work} [get_files { rtl/axi4lite_slave_regsif.vhd} ]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
ipx::package_project - import files -root_dir {axi4lite_slave_regsif}
set_property vendor {vac} [ipx::current_core]
set_property library {elements} [ipx::current_core]
set_property vendor_display_name {vac} [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property ip_repo_paths  axi4lite_slave_regsif [current_fileset]
update_ip_catalog
exit
