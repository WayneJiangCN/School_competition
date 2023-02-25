//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved
//----------------------------------------------------------------------------------------
// File name:           video_display
// Last modified Date:  2020/05/28 20:28:08
// Last Version:        V1.0
// Descriptions:        视频显示模块，显示彩条
//                      
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2020/05/28 20:28:08
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module  video_display(
    input                pixel_clk,
    input                sys_rst_n,
    
    input        [10:0]  pixel_xpos,  //像素点横坐标
    input        [10:0]  pixel_ypos,  //像素点纵坐标
    output       reg [23:0]  pixel_data,   //像素点数据
    
    input        ad_clk     ,
    input  [7:0] ad_data    ,
    input                 key_add,
    input key_p

);

//parameter define
parameter  H_DISP = 11'd1280;                       //分辨率——行
parameter  V_DISP = 11'd720;                        //分辨率——列

////读写使能控制
reg wea;
reg [10:0] wr_addr;
//always@(negedge sys_rst_n or posedge ad_clk)begin
//    if(!sys_rst_n)
//        wea <= 1'b1;
//    else 
//        wea <= 1'b1;

//end
////写坐标控制
//always@(posedge ad_clk or negedge sys_rst_n)begin
//    if(!sys_rst_n)
//        wr_addr <= 11'b0;

//    else if(wea)begin
//        if(wr_addr >= H_DISP - 1'b1)
//            wr_addr <= 11'b0;
//        else
//            wr_addr <= wr_addr + 1'b1;
//    end
//    else
//        wr_addr <= wr_addr;
//end
always@(negedge sys_rst_n or posedge key_p or posedge key_add or posedge ad_clk)begin
    if(!sys_rst_n)
        wea <= 1'b1;
    else if(key_p||key_add)
        wea <= 1'b1;
    else if(wr_addr >= H_DISP - 1'b1)
        wea <= 1'b0;
end
//写坐标控制
always@(posedge ad_clk or negedge sys_rst_n)begin
    if(!sys_rst_n)
        wr_addr <= 11'b0;
    else if(key_p||key_add)
        wr_addr <= 11'b0;
    else if(wea)begin
        if(wr_addr >= H_DISP - 1'b1)
            wr_addr <= 11'b0;
        else
            wr_addr <= wr_addr + 1'b1;
    end
    else
        wr_addr <= wr_addr;
end

//wave_pos为每一列波形所在的横坐标
//扫描时横坐标和纵坐标
wire [10:0] wave_pos;
always@(*)begin
    if((pixel_ypos >= wave_pos - 1)&&(pixel_ypos <= wave_pos + 1))
        pixel_data = 24'h000000;
    else if((pixel_ypos == 11'd360)||(pixel_xpos[7:0] == 8'b00000000))
        pixel_data = 24'h00ff00;
    else
        pixel_data = 24'hDDDDDD;
end

//将256的数据稍微转换为720左右
wire [10:0] din_a;
assign din_a = ad_data *2  + 7'd104;

dis_ram u_dis_ram (
  .clka(ad_clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(wr_addr),  // input wire [10 : 0] addra
  .dina(din_a),    // input wire [10 : 0] dina
  .clkb(pixel_clk),    // input wire clkb
  .addrb(pixel_xpos),  // input wire [10 : 0] addrb
  .doutb(wave_pos)  // output wire [10 : 0] doutb
);
endmodule