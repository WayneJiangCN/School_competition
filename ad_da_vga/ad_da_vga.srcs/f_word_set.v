`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/22 21:57:52
// Design Name: 
// Module Name: f_word_set
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

module f_word_set(
	input				sys_clk	,
	input				sys_rst_n,
	input			    key_add,//�������ִ������ļӷ��ź�
 	input 			    key_sub,//�������ִ������ļӷ��ź�
	output	reg	  [10:0]FREQ_CTRL  //���ȷ����Ƶ��ֵ	
	);
	wire            key2   ;   //����2
    wire            key3   ;   //����3

reg     [4:0]   fre_select;


//FREQ_100 = 11'd1953;  //Ƶ�ʵ���,FREQ_ADJ��Խ��,���������Ƶ��Խ��,��Χ0~255


always @(posedge sys_clk or negedge sys_rst_n)begin
    if (!sys_rst_n) begin
    FREQ_CTRL<= 11'd1953; //ֱ�����͵�ƽ��ֵ ����100Hz�Ĳ���
    end
   else begin
           case(fre_select)
   5'd0: FREQ_CTRL<= 11'd5;
   5'd1: FREQ_CTRL<= 11'd20;
   5'd2: FREQ_CTRL<= 11'd40;
   5'd3: FREQ_CTRL<= 11'd60;
   5'd4: FREQ_CTRL<= 11'd80;
   5'd5: FREQ_CTRL<= 11'd100;
   5'd6: FREQ_CTRL<= 11'd150;
   5'd7: FREQ_CTRL<= 11'd244;
   5'd8: FREQ_CTRL<= 11'd217; 
   5'd9: FREQ_CTRL<= 11'd195;     
   default: FREQ_CTRL<= 11'd1953;
//        case(fre_select)
//        5'd0: FREQ_CTRL<= 11'd1953;
//        5'd1: FREQ_CTRL<= 11'd977;
//        5'd2: FREQ_CTRL<= 11'd651;
//        5'd3: FREQ_CTRL<= 11'd488;
//        5'd4: FREQ_CTRL<= 11'd390;
//        5'd5: FREQ_CTRL<= 11'd325;
//        5'd6: FREQ_CTRL<= 11'd279;
//        5'd7: FREQ_CTRL<= 11'd244;
//        5'd8: FREQ_CTRL<= 11'd217; 
//        5'd9: FREQ_CTRL<= 11'd195;     
//        default: FREQ_CTRL<= 11'd1953;
   
   endcase
   end
end
                     //������������������
         key_f fword_key_add(
         .sys_clk       (sys_clk),
         .sys_rst_n     (sys_rst_n),
         .key_in    (key_add),
         .key_flag  (key2)// 
         
);
         key_f fword_key_sub(
         .sys_clk       (sys_clk),
         .sys_rst_n     (sys_rst_n),
         .key_in    (key_sub),
         .key_flag  (key3)
         
);
	always @(posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n) begin
            fre_select <= 5'd0;
		end 
        else if(key2)begin
        //ÿ�μ�500FREQ_CTRL=FREQ_CTRL+32'd42949;//
         fre_select  <= fre_select + 5'd1;
        end
        else if(key3)begin
     //   FREQ_CTRL=FREQ_CTRL-32'd42949;//
        fre_select  <= fre_select - 5'd1;
        end
        else if(fre_select >= 5'd10)begin
        fre_select  <= 5'd0; 
        end
         else
         fre_select = fre_select;

  end
//ILA�ɼ�AD����
  ila_1  ila_1 (
      .clk         (sys_clk ), // input wire clk
      .probe0      (fre_select ), // input wire [0:0]  probe0  
      .probe1      (FREQ_CTRL)  // input wire [7:0]  probe0
 
  );
endmodule