module pass( 
  input clk,reset_n, //?????? ?? ??? ????? ???????
 input sensor_entrance, // ???? ?? ??? ???? ???????
 input [1:0] password_1, password_2, // ?????? ????? ?????? ?????? ???? ??????
 output wire GREEN_LED,RED_LED); // ?????? ??????? ?????? ??? ????? ???? ??????

parameter IDLE = 3'b000, CKECK_PASSWORD = 3'b001, // ????? ??????? ?????? ?????? ??? ?????
WRONG_PASS = 3'b010, RIGHT_PASS = 3'b011;

reg[3:0] counter_wait; // ????? ??? ???? ????????
reg[2:0] current_state; // ??????? ???? ???? ?????? 
reg[2:0] current_state1;
 reg red_tmp,green_tmp;

always @(posedge clk or negedge reset_n) // ????? ????? ?? ??? ????? ??????? ???? ???? ??????
 begin
if(~reset_n) 
current_state=IDLE;
 else if( current_state==CKECK_PASSWORD)
   counter_wait <= counter_wait+1;
else if( current_state==CKECK_PASSWORD)
   current_state= current_state1;
 else 
 counter_wait <=0;
 end

always @(*) // ????? ??????? ???? ????? ??????? ??????
begin 
 case(current_state)

 IDLE: begin // ?????? ?? ?????? ????????
if(sensor_entrance ==1 )
current_state1=CKECK_PASSWORD;
 end


 CKECK_PASSWORD: begin // ?????? ?? ???? ??? ???? ??????
if(counter_wait<=3)
current_state1=CKECK_PASSWORD;
else
 if((password_1==2'b01)&&(password_2==2'b10))
  current_state1= RIGHT_PASS;
 else
 current_state1 = WRONG_PASS;
 end

 WRONG_PASS: begin // ?????? ?? ?????? ???????

 green_tmp = 1'b0;
 red_tmp = ~red_tmp;
 
 end

 RIGHT_PASS: begin // ?????? ?? ???? ??????

 green_tmp = ~green_tmp;
 red_tmp = 1'b0;
 end

 endcase
 end

 assign RED_LED = red_tmp  ;
 assign GREEN_LED = green_tmp;

endmodule




