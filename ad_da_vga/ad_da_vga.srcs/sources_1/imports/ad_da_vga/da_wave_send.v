module da_wave_send(
    input                 clk    ,  //时钟
    input                 rst_n  ,  //复位信号，低电平有效
    
    input        [7:0]    rd_data,  //ROM读出的数据
    input                 key_add,
    input                 key_sub,
    output  reg  [7:0]    rd_addr,  //读ROM地址
    //DA芯片接口
    output                da_clk ,  //DA(AD9708)驱动时钟,最大支持125Mhz时钟
    output       [7:0]    da_data   //输出给DA的数据  
    );

//parameter
//频率调节控制
//parameter  FREQ_ADJ = 8'd3;  //频率调节,FREQ_ADJ的越大,最终输出的频率越低,范围0~255

//reg define
reg    [7:0]    freq_cnt  ;  //频率调节计数器
wire    [10:0]    FREQ_ADJ  ;  //频率调节计数器

//*****************************************************
//**                    main code
//*****************************************************

//数据rd_data是在clk的上升沿更新的，所以DA芯片在clk的下降沿锁存数据是稳定的时刻
//而DA实际上在da_clk的上升沿锁存数据,所以时钟取反,这样clk的下降沿相当于da_clk的上升沿
assign  da_clk = ~clk;       
assign  da_data = rd_data;   //将读到的ROM数据赋值给DA数据端口

//频率调节计数器
always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        freq_cnt <= 8'd0;
    else if(freq_cnt == FREQ_ADJ)    
        freq_cnt <= 8'd0;
    else         
        freq_cnt <= freq_cnt + 8'd1;
end

//读ROM地址
always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        rd_addr <= 8'd0;
    else begin
        if(freq_cnt == FREQ_ADJ) begin
            rd_addr <= rd_addr + 8'd1;
        end    
    end            
end
 f_word_set u_f_word_set(
       .sys_clk(clk)     ,
       .sys_rst_n(rst_n),
       .key_add(key_add),//按键部分传过来的加法信号
        .key_sub(key_sub),//按键部分传过来的加法信号
       .FREQ_CTRL(FREQ_ADJ)  //输出确定的频率值    
   );
endmodule