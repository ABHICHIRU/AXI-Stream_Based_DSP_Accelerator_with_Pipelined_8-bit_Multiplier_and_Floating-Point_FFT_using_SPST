create_clock -period 10.0 [get_ports clk] -name clk

set_input_delay 2.5 -clock clk [get_ports s_real]
set_input_delay 2.5 -clock clk [get_ports s_imag]
set_input_delay 2.5 -clock clk [get_ports s_valid]
set_input_delay 2.5 -clock clk [get_ports rst_n]

set_output_delay 2.5 -clock clk [get_ports m_real]
set_output_delay 2.5 -clock clk [get_ports m_imag]
set_output_delay 2.5 -clock clk [get_ports m_valid]
set_output_delay 2.5 -clock clk [get_ports s_ready]

set_clock_uncertainty 0.1 -clock clk

set_max_transition 0.3 -from [get_ports s_real s_imag s_valid rst_n]

set_drive 12.5 [get_ports s_real s_imag s_valid rst_n]
set_load 5.0 [get_ports m_real m_imag m_valid s_ready]

set_false_path -from [get_ports rst_n]
