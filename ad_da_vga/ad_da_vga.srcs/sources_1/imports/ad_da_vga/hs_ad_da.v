module hs_ad_da(
    input                 sys_clk     ,  //系统时钟
    input                 sys_rst_n   ,  //系统复位，低电平有效
    input                 contrl_key  , //波形切换按键
    input                 key_add,
    input                 key_sub,
    //DA芯片接口
    output                da_clk      ,  //DA(AD9708)驱动时钟,最大支持125Mhz时钟
    output    [7:0]       da_data     ,  //输出给DA的数据
    //AD芯片接口
    input     [7:0]       ad_data     ,  //AD输入数据
    //模拟输入电压超出量程标志(本次试验未用到)
    input                 ad_otr      ,  //0:在量程范围 1:超出量程
    output                ad_clk       ,  //AD(AD9280)驱动时钟,最大支持32Mhz时钟 
    output       tmds_clk_p,    // TMDS 时钟通道
    output       tmds_clk_n,
    output [2:0] tmds_data_p,   // TMDS 数据通道
    output [2:0] tmds_data_n,
    output       tmds_oen      // TMDS 输出使能
);



wire key_p;




hdmi_colorbar_top u_hdmi_colorbar_top(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n), 
    .tmds_clk_p(tmds_clk_p),    // TMDS 时钟通道
    .tmds_clk_n(tmds_clk_n),
    .tmds_data_p(tmds_data_p),   // TMDS 数据通道
    .tmds_data_n(tmds_data_n),
    .tmds_oen(tmds_oen),      // TMDS 输出使能
    
    .ad_clk(ad_clk),
    .ad_data(ad_data),
    .key_p(key_p),
    .key_add(key_add)

);

//wire define 
wire      [7:0]    rd_addr;              //ROM读地址
wire      [7:0]    rd_data;              //ROM读出的数据
//*****************************************************
//**                    main code
//*****************************************************

//DA数据发送
da_wave_send u_da_wave_send(
    .clk         (sys_clk), 
    .rst_n       (sys_rst_n),
    .rd_data     (rd_data),
    .rd_addr     (rd_addr),
    .key_add     (key_add),
    .key_sub    (key_sub),
    .da_clk      (da_clk),  
    .da_data     (da_data)
    );
	
//ROM存储波形
rom_part u_rom_part(
	.sys_clk (sys_clk)    ,  //系统时钟
	.sys_rst_n(sys_rst_n)   ,  //系统复位，低电平有效
	.contrl_key(contrl_key)  , //波形切换按键
	.rd_addr(rd_addr),
	.rd_data(rd_data),
	.key_p(key_p)     
);
//wire ad_clk; 
////AD数据接收
//ad_wave_rec u_ad_wave_rec(
//    .clk         (sys_clk),
//    .rst_n       (sys_rst_n),
//    .ad_data     (ad_data),
//    .ad_otr      (ad_otr),
//    .ad_clk      (ad_clk)
//    );   
ila_fre u_ad_wave_rec(
    .clk         (sys_clk),
    .rst_n       (sys_rst_n),
    .ad_clk      (ad_clk)
    );
reg [31:0] trigger_cnt;
    wire [12:0] Vio_freq_div;
    wire trigger;
    always@(posedge sys_clk or negedge sys_rst_n)begin
    if(!sys_rst_n) begin;
    trigger_cnt <= 32'd0;
    end
    else if(trigger_cnt >= Vio_freq_div) begin
    trigger_cnt <= 32'd0;
    end
    else begin
    trigger_cnt <= trigger_cnt + 32'd1;
    end
    end
        
    assign trigger = (trigger_cnt==Vio_freq_div);
    
    vio_0 vio_0 (
    .clk(sys_clk),                // input wire clk
    .probe_out0(Vio_freq_div)
    );
 
//ILA采集AD数据
ila_0  ila_0 (
    .clk         (sys_clk ), // input wire clk
    .probe0      (ad_otr ), // input wire [0:0]  probe0  
    .probe1      (ad_data),  // input wire [7:0]  probe0
    .probe2      (trigger)  
);

endmodule