
set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib
set_db hdl_search_path /home/vgnaiduk/Desktop/abhi
set_db library slow.lib
read_hdl darshu.v
elaborate fft8_f32_stream
read_sdc /home/vgnaiduk/Desktop/abhi/constraints_sdc.sdc
set_db syn_generic_effort medium
syn_generic

set_db syn_map_effort medium
syn_map

set_db syn_opt_effort medium
syn_opt

write_hdl fft8_f32_stream > darshu_netlist.v
write_sdc fft8_f32_stream > darshu_block.sdc
report_area fft8_f32_stream > darshu_area.rep
report_gates fft8_f32_stream > darshu_gate.rep
report_power -design fft8_f32_stream > darshu_power.rep
report_timing fft8_f32_stream > darshu_timing.rep



gui_show
