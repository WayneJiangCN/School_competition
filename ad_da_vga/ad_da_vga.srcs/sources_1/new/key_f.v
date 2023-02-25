`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/24 15:05:04
// Design Name: 
// Module Name: key_f
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/22 21:59:04
// Design Name: 
// Module Name: key_filter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale  1ns/1ns
module  key_f
#(
    parameter CNT_MAX = 20'd999_999 //�������������ֵ
)
(
    input   wire    sys_clk     ,   //ϵͳʱ��50Mhz
    input   wire    sys_rst_n   ,   //ȫ�ָ�λ
    input   wire    key_in      ,   //���������ź�

    output  reg     key_flag        //key_flagΪ1ʱ��ʾ�������⵽����������
                                    //key_flagΪ0ʱ��ʾû�м�⵽����������
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//
//reg   define
reg     [19:0]  cnt_20ms    ;   //������

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//cnt_20ms:���ʱ�ӵ������ؼ�⵽�ⲿ���������ֵΪ�͵�ƽʱ����������ʼ����
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_20ms <= 20'b0;
    else    if(key_in == 1'b1)
        cnt_20ms <= 20'b0;
    else    if(cnt_20ms == CNT_MAX && key_in == 1'b0)
        cnt_20ms <= cnt_20ms;
    else
        cnt_20ms <= cnt_20ms + 1'b1;

//key_flag:��������20ms�����������Ч��־λ
//��key_flag��999_999ʱ����,ά��һ��ʱ�ӵĸߵ�ƽ
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        key_flag <= 1'b0;
    else    if(cnt_20ms == CNT_MAX - 1'b1)
        key_flag <= 1'b1;
    else
        key_flag <= 1'b0;

endmodule

