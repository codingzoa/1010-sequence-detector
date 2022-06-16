Copyright 2022. (Hyeonsu Lee) All rights reserved. 
    

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Seq_Detector_Moore is
  port(
  CLK : in std_logic;           --input : CLK, RESET(asyn), X
  RESET : in std_logic;
  X: in std_logic;
  Z: out std_logic              --output : Z(when sequence is '1010' Z='1')
  );
end Seq_Detector_Moore;

architecture Behavioral of Seq_Detector_Moore is
    type states is (s0,s1,s2,s3,s4);               --최소 state 개수가 5개
    signal state, next_state : states;             -- state와 next state는 s0, s1, s2, s3, s4일 수 있다.
    
begin
--state transition
    process(RESET, CLK)                             
        begin                                       
            if (RESET = '0') then                   --RESET은 asynchronous, active low이기 때문에 
            state<=s0;                              --CLK와 별개로 0이면 initial 상태로 초기화
            elsif (CLK='1' and CLK'event) then      --RESET이 1일 때 CLK 상승 엣지에서 
            state<= next_state;                     --next state로 변화
            end if;
    end process;
    
    --outputs
    process(state)
        begin
            case state is                   --state diagram을 참고하여 각각의 state에 따른 출력값 설정
            when s0 => Z<='0';              --moore machine은 오직 state에 따라 출력값이 변화
            when s1 => Z<='0';
            when s2 => Z<='0';
            when s3 => Z<='0';
            when s4 => Z<='1';
            end case;
            
    end process;
    --next state
    process(X)
    begin
        case state is                           
         when s0 =>
            if X='0' then next_state<=s0;    --s0일 때 입력이 0이면 next state s0
            else next_state<= s1; end if;    --s0일 때 입력이 1이면 next state s1
         when s1 =>
            if X='0' then next_state<=s2;   --s1일 때 입력이 0이면 next state s2
            else next_state<= s1; end if;   --s1일 때 입력이 1이면 next state s1
         when s2 =>
            if X='0' then next_state<=s0;   --s2일 때 입력이 0이면 next state s0
            else next_state<= s3; end if;   --s2일 때 입력이 1이면 next state s3
         when s3 =>
            if X='0' then next_state<=s4;   --s3일 때 입력이 0이면 next state s4
            else next_state<= s1; end if;   --s3일 때 입력이 1이면 next state s1
         when s4 =>
            if X='0' then next_state<=s0;   --s4일 때 입력이 0이면 next state s0
            else next_state<= s3; end if;   --s4일 때 입력이 1이면 next state s3
         when others => null;
        end case;
    end process;

end Behavioral;
