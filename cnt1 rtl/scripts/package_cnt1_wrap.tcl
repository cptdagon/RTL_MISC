#-----------------------------------------------------------
# Vivado v2013.4 (64-bit)
# SW Build 353583 on Mon Dec  9 17:26:26 MST 2013
# IP Build 208076 on Mon Dec  2 12:38:17 MST 2013
# Start of session at: Thu Jan 23 12:09:11 2014
# Process ID: 8901
# Log file: /home/elvc/work/projects/elements/vivado.log
# Journal file: /home/elvc/work/projects/elements/vivado.jou
#-----------------------------------------------------------
create_project -force cnt1_wrap cnt1_wrap -part xc7z020clg484-1
set_property board xilinx.com:zynq:zc706:1.1 [current_project]
set_property target_language VHDL [current_project]
add_files -norecurse rtl/cnt1_wrap.vhd

#add_files -norecurse /home/elvc/work/projects/elements/rtl/functions_pkg.vhd
#add_files -norecurse /home/elvc/work/projects/elements/rtl/axi4_dma.vhd
set_property library {work} [get_files { rtl/cnt1_wrap.vhd} ]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
ipx::package_project -root_dir {cnt1_wrap}
set_property vendor {vac} [ipx::current_core]
set_property library {elements} [ipx::current_core]
set_property vendor_display_name {vac} [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property ip_repo_paths  cnt1_wrap [current_fileset]
update_ip_catalog
exit
