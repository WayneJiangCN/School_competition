module ad_wave_rec(
    input                 clk         ,  //ʱ��
    input                 rst_n       ,  //��λ�źţ��͵�ƽ��Ч
    
    input         [7:0]   ad_data     ,  //AD��������
    //ģ�������ѹ�������̱�־(��������δ�õ�)
    input                 ad_otr      ,  //0:�����̷�Χ 1:��������
    output   reg          ad_clk         //AD(TLC5510)����ʱ��,���֧��20Mhzʱ��
    );

//*****************************************************
//**                    main code 
//*****************************************************

//ʱ�ӷ�Ƶ(2��Ƶ,ʱ��Ƶ��Ϊ25Mhz),����ADʱ��  8KHZ 
always @(posedge clk or negedge rst_n)
    if(rst_n == 1'b0)
        ad_clk <= 1'b0;

        else 
            ad_clk <= ~ad_clk; 



endmodule