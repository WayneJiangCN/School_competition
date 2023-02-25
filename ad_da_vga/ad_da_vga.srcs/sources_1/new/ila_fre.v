`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/25 11:37:14
// Design Name: 
// Module Name: ila_fre
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



module ila_fre(
    input                 clk         ,  //时钟
    input                 rst_n       ,  //复位信号，低电平有效

    output   reg          ad_clk         //AD(TLC5510)驱动时钟,最大支持20Mhz时钟
    );

//*****************************************************
//**                    main code 
//*****************************************************

//时钟分频(2分频,时钟频率为25Mhz),产生AD时钟  8KHZ 
reg [12:0] cnt;
always @(posedge clk or negedge rst_n) begin
        if(rst_n == 1'b0)begin
            ad_clk <= 1'b0;
            cnt <= 13'd0;
            end
        else if(cnt == 13'd49)begin
            cnt <= 13'd0;
            ad_clk <= ~ad_clk; 
            
            end 
       else begin 
            cnt <= cnt + 6'd1;
            ad_clk <= ad_clk;
            end
end
endmodule
