module rom_part(
    input                 sys_clk     ,  //系统时钟
    input                 sys_rst_n   ,  //系统复位，低电平有效
	input                 contrl_key  , //波形切换按键
	input 					[7:0] rd_addr		,
    output    reg [7:0]       rd_data     ,
    output  key_p
);
wire [7:0] sin_data;
wire [7:0] sawt_data;
wire [7:0] tri_data;

key_filter2 u_key_filter(
    .Clk(sys_clk),
    .Reset_n(sys_rst_n),
    .Key(contrl_key),
    .Key_P_Flag(key_p),
    .Key_R_Flag(),
    .Key_State()
);

reg [1:0] wave_num;
always@(posedge sys_clk or negedge sys_rst_n)begin
    if(!sys_rst_n)
        wave_num <= 2'b00;
    else if(key_p)begin
        if(wave_num < 2'b10)
            wave_num <= wave_num + 1'b1;
        else
            wave_num <= 2'b00;
    end
    else
        wave_num <= wave_num;
end

always@(*)begin
    case(wave_num)
        2'b00:rd_data = sin_data;
        2'b01:rd_data = sawt_data;
        2'b10:rd_data = tri_data;
        default : rd_data = sin_data;
    endcase
end
rom_256x8b  u_rom_256x8b (
  .clka  (sys_clk),    // input wire clka
  .addra (rd_addr),    // input wire [7 : 0] addra
  .douta (sin_data)     // output wire [7 : 0] douta
);

sawt_rom u_sawt_rom (
  .clka(sys_clk),    // input wire clka
  .addra(rd_addr),  // input wire [7 : 0] addra
  .douta(sawt_data)  // output wire [7 : 0] douta
);

tri_rom u_tri_rom (
  .clka(sys_clk),    // input wire clka
  .addra(rd_addr),  // input wire [7 : 0] addra
  .douta(tri_data)  // output wire [7 : 0] douta
);
endmodule