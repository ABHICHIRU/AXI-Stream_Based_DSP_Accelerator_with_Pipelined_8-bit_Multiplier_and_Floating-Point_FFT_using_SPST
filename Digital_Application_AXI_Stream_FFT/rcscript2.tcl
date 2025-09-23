# Initialize library and HDL search paths
set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib
set_db hdl_search_path /home/vgnaiduk/Desktop/abhi3

# Use fast library for min timing
set_db library fast.lib

# Read design source and elaborate top-level
read_hdl darshu.v
elaborate fft8_f32_stream

# Read fixed constraints with explicit port names
read_sdc /home/vgnaiduk/Desktop/abhi3/constraints_sdc.sdc

# Check timing and produce timing report (top 10 paths)
check_timing
report_timing -max_paths 10 > darshu_timing_fast.rep

# Generate power report
report_power > darshu_power_fast.rep

# Launch GUI for results examination
gui_show

