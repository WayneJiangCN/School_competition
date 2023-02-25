

#Ê±ÐòÔ¼Êø
create_clock -period 20.000 -name sys_clk [get_ports sys_clk]

#set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]
#set_property PACKAGE_PIN U18 [get_ports sys_clk]
#set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]
#set_property PACKAGE_PIN N16 [get_ports sys_rst_n]
#set_property IOSTANDARD TMDS_33 [get_ports {tmds_data_p[2]}]
#set_property IOSTANDARD TMDS_33 [get_ports {tmds_data_p[1]}]
#set_property IOSTANDARD TMDS_33 [get_ports {tmds_data_p[0]}]
#set_property PACKAGE_PIN K19 [get_ports {tmds_data_p[0]}]
#set_property PACKAGE_PIN M14 [get_ports {tmds_data_p[1]}]
#set_property PACKAGE_PIN L16 [get_ports {tmds_data_p[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports tmds_oen]
#set_property PACKAGE_PIN G17 [get_ports tmds_oen]
#set_property IOSTANDARD TMDS_33 [get_ports tmds_clk_p]
#set_property PACKAGE_PIN L14 [get_ports tmds_clk_p]
set_property -dict {PACKAGE_PIN L16  IOSTANDARD TMDS_33 } [get_ports {tmds_data_p[2]}]
set_property -dict {PACKAGE_PIN M14  IOSTANDARD TMDS_33 } [get_ports {tmds_data_p[1]}]
set_property -dict {PACKAGE_PIN K19  IOSTANDARD TMDS_33 } [get_ports {tmds_data_p[0]}]
set_property -dict {PACKAGE_PIN L14  IOSTANDARD TMDS_33 } [get_ports tmds_clk_p]

set_property -dict {PACKAGE_PIN G17  IOSTANDARD LVCMOS33} [get_ports tmds_oen]

set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN L20} [get_ports key_add]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN W19} [get_ports key_sub]


set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U18} [get_ports sys_clk]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN N16} [get_ports sys_rst_n]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T19} [get_ports {da_data[7]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R19} [get_ports {da_data[6]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P18} [get_ports {da_data[5]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R18} [get_ports {da_data[4]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN N17} [get_ports {da_data[3]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T17} [get_ports {da_data[2]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P16} [get_ports {da_data[1]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P15} [get_ports {da_data[0]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN K18} [get_ports da_clk]

set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN B19} [get_ports {ad_data[7]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN B20} [get_ports {ad_data[6]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN C20} [get_ports {ad_data[5]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN H20} [get_ports {ad_data[4]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P19} [get_ports {ad_data[3]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R16} [get_ports {ad_data[2]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN N18} [get_ports {ad_data[1]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R17} [get_ports {ad_data[0]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U19} [get_ports ad_clk]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN K16} [get_ports ad_otr]

set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN J20} [get_ports contrl_key]


#set_property IOSTANDARD LVCMOS33 [get_ports hpdin]
#set_property PACKAGE_PIN R6 [get_ports hpdin]

#set_property IOSTANDARD LVCMOS33 [get_ports hpdout]
#set_property PACKAGE_PIN F4 [get_ports hpdout]

#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN K22} [get_ports {ad_data[7]}]
#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN K21} [get_ports {ad_data[6]}]
#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN J22} [get_ports {ad_data[5]}]
#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN H22} [get_ports {ad_data[4]}]
#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN G22} [get_ports {ad_data[3]}]
#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN G21} [get_ports {ad_data[2]}]
#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN E19} [get_ports {ad_data[1]}]
#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN D19} [get_ports {ad_data[0]}]

#set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN L21} [get_ports ad_otr]