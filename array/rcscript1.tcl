# RTL Script to run Basic Synthesis Flow
set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib   
set_db hdl_search_path /home/vgnaiduk/Desktop/arraymul


set_db library slow.lib
read_hdl arr2.v
elaborate 
read_sdc /home/vgnaiduk/Desktop/arraymul/constraints_sdc.sdc
set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt


write_hdl > arr2_netlist.v
write_sdc > arr2_block.sdc
report_area > arr2_area.rep
report_gates > arr2_gate.rep
report_power > arr2_power.rep
report_timing > arr2_timing.rep
gui_show


