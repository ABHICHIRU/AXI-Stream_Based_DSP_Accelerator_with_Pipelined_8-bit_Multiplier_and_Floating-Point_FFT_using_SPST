# RTL Script to run Basic Synthesis Flow
set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib   
set_db hdl_search_path /home/others/Desktop/1kg20ec025/exp2a


set_db library slow.lib
read_hdl dlatch.v
elaborate 
read_sdc /home/others/Desktop/1kg20ec025/constraints_sdc.sdc
set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt


write_hdl > dlatch_netlist.v
write_sdc > dlatch_block.sdc
report_area > dlatch_area.rep
report_gates > dlatch_gate.rep
report_power > dlatch_power.rep
report_timing > dlatch_timing.rep
gui_show


