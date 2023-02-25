module key_filter(
    Clk,
    Reset_n,
    Key,
    Key_P_Flag,
    Key_R_Flag,
    Key_State
);
    input Clk;
    input Reset_n;
    input Key;
    output reg Key_P_Flag;
    output reg Key_R_Flag;
    output reg Key_State;
    
    reg [1:0] sync_key;
    always@(posedge Clk) 
        sync_key <= {sync_key[0],Key};
    
    reg [1:0] r_Key;
    always@(posedge Clk)
        r_Key <= {r_Key[0],sync_key[1]};
//        r_Key[0] <= Key; r_Key[1] <= r_Key[0];
    
    wire pedge_key;
    assign pedge_key = (r_Key == 2'b01)? 1:0;
    wire nedge_key;
    assign nedge_key = (r_Key == 2'b10)? 1:0;
    
    
    reg [1:0] state;
    reg [19:0] tcnt;
    always@(posedge Clk or negedge Reset_n)
        if(!Reset_n)begin
            state <= 0;
            tcnt <= 0;
            Key_R_Flag <= 0;
            Key_P_Flag <= 0;
            Key_State <= 1;
        end
        else begin
            case(state)
                0:begin
                    Key_R_Flag <= 0;
                    if(nedge_key)
                        state <= 1;
                    else
                        state <= 0;
                end
                1:begin
                    if(tcnt >= 1000000-1)begin
                        state <= 2;
                        Key_P_Flag <= 1;
                        Key_State <= 0;
                        tcnt <= 0;
                    end
                    else if((tcnt < 1000000 - 1)&&(pedge_key == 1))begin
                        state <= 0;
                        tcnt <= 0;
                    end
                    else begin
                        state <= 1;
                        tcnt <= tcnt + 1;
                    end
                        
                end
                2:begin
                    Key_P_Flag <= 0;
                    if(pedge_key)
                        state <= 3;
                    else
                        state <= 2;
                end
                3:begin
                    if((tcnt < 1000000 - 1)&&(nedge_key))begin
                        state <= 2;
                        tcnt <= 0;
                    end
                    else if(tcnt >= 1000000 - 1)begin
                        state <= 0;
                        Key_R_Flag <= 1;
                        Key_State <= 1;
                    end
                    else
                        tcnt <= tcnt + 1;
                end
            endcase
        end
endmodule