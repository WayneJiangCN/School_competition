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
    input                 clk         ,  //ʱ��
    input                 rst_n       ,  //��λ�źţ��͵�ƽ��Ч

    output   reg          ad_clk         //AD(TLC5510)����ʱ��,���֧��20Mhzʱ��
    );

//*****************************************************
//**                    main code 
//*****************************************************

//ʱ�ӷ�Ƶ(2��Ƶ,ʱ��Ƶ��Ϊ25Mhz),����ADʱ��  8KHZ 
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
