Copyright 2022. (Hyeonsu Lee) All rights reserved. 
  
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Seq_Detector_Mealy is
  port(
  CLK : in std_logic;           --input : CLK, RESET(asyn), X
  RESET : in std_logic;
  X: in std_logic;
  Z: out std_logic              --output : Z(when sequence is '1010' Z='1')
  );
end Seq_Detector_Mealy;

architecture Behavioral of Seq_Detector_Mealy is
    type states is (s0,s1,s2,s3);               --최소 state 개수가 4개
    signal state, next_state : states;             -- state와 next state는 s0, s1, s2, s3일 수 있다.
    
begin
--state transition
    process(RESET, CLK)                             
        begin                                       --state reg는 sequential logic이기 때문에 clk에 따라 값 변화
            if (RESET = '0') then                   --RESET은 asynchronous, active low이기 때문에 
            state<=s0;                              --CLK와 별개로 0이면 initial 상태로 초기화
            elsif (CLK='1' and CLK'event) then      --RESET이 1일 때 CLK 상승 엣지에서 
            state<= next_state;                     --next state로 변화
            end if;
    end process;
    
    --outputs, next state
    process(X, state)                           --mealy machine의 출력은 입력과 현재 state에 따라 바뀜
    begin
        case state is                           
         when s0 =>
            if X='0' then next_state<=s0; Z<='0';    --s0일 때 X가 0이면 next state는 s0, 출력 0
            else next_state<= s1;Z<='0';             --s0일 때 X가 1이면 next state는 s1, 출력 0
            end if;
         when s1 =>
            if X='0' then next_state<=s2;Z<='0';   --s1일 때 X가 0이면 next state는 s2, 출력 0
            else next_state<= s1;Z<='0';           --s1일 때 X가 1이면 next state는 s1, 출력 0
            end if;
         when s2 =>
            if X='0' then next_state<=s0;Z<='0';   --s2일 때 X가 0이면 next state는 s0, 출력 0
            else next_state<= s3;Z<='0';           --s2일 때 X가 1이면 next state는 s3, 출력 0
            end if;
         when s3 =>
            if X='0' then next_state<=s2;Z<='1';   --s3일 때 X가 0이면 next state는 s2, 출력 1
            else next_state<= s1; Z<='0';          --s3일 때 X가 1이면 next state는 s1, 출력 0
            end if;
         when others => null;
        end case;
    end process;

end Behavioral;
