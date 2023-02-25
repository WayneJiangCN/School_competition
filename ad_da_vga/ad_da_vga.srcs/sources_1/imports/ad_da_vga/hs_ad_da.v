module hs_ad_da(
    input                 sys_clk     ,  //ϵͳʱ��
    input                 sys_rst_n   ,  //ϵͳ��λ���͵�ƽ��Ч
    input                 contrl_key  , //�����л�����
    input                 key_add,
    input                 key_sub,
    //DAоƬ�ӿ�
    output                da_clk      ,  //DA(AD9708)����ʱ��,���֧��125Mhzʱ��
    output    [7:0]       da_data     ,  //�����DA������
    //ADоƬ�ӿ�
    input     [7:0]       ad_data     ,  //AD��������
    //ģ�������ѹ�������̱�־(��������δ�õ�)
    input                 ad_otr      ,  //0:�����̷�Χ 1:��������
    output                ad_clk       ,  //AD(AD9280)����ʱ��,���֧��32Mhzʱ�� 
    output       tmds_clk_p,    // TMDS ʱ��ͨ��
    output       tmds_clk_n,
    output [2:0] tmds_data_p,   // TMDS ����ͨ��
    output [2:0] tmds_data_n,
    output       tmds_oen      // TMDS ���ʹ��
);



wire key_p;




hdmi_colorbar_top u_hdmi_colorbar_top(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n), 
    .tmds_clk_p(tmds_clk_p),    // TMDS ʱ��ͨ��
    .tmds_clk_n(tmds_clk_n),
    .tmds_data_p(tmds_data_p),   // TMDS ����ͨ��
    .tmds_data_n(tmds_data_n),
    .tmds_oen(tmds_oen),      // TMDS ���ʹ��
    
    .ad_clk(ad_clk),
    .ad_data(ad_data),
    .key_p(key_p),
    .key_add(key_add)

);

//wire define 
wire      [7:0]    rd_addr;              //ROM����ַ
wire      [7:0]    rd_data;              //ROM����������
//*****************************************************
//**                    main code
//*****************************************************

//DA���ݷ���
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
	
//ROM�洢����
rom_part u_rom_part(
	.sys_clk (sys_clk)    ,  //ϵͳʱ��
	.sys_rst_n(sys_rst_n)   ,  //ϵͳ��λ���͵�ƽ��Ч
	.contrl_key(contrl_key)  , //�����л�����
	.rd_addr(rd_addr),
	.rd_data(rd_data),
	.key_p(key_p)     
);
//wire ad_clk; 
////AD���ݽ���
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
 
//ILA�ɼ�AD����
ila_0  ila_0 (
    .clk         (sys_clk ), // input wire clk
    .probe0      (ad_otr ), // input wire [0:0]  probe0  
    .probe1      (ad_data),  // input wire [7:0]  probe0
    .probe2      (trigger)  
);

endmodule