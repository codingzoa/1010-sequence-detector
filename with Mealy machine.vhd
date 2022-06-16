
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
    type states is (s0,s1,s2,s3);               --�ּ� state ������ 4��
    signal state, next_state : states;             -- state�� next state�� s0, s1, s2, s3�� �� �ִ�.
    
begin
--state transition
    process(RESET, CLK)                             
        begin                                       --state reg�� sequential logic�̱� ������ clk�� ���� �� ��ȭ
            if (RESET = '0') then                   --RESET�� asynchronous, active low�̱� ������ 
            state<=s0;                              --CLK�� ������ 0�̸� initial ���·� �ʱ�ȭ
            elsif (CLK='1' and CLK'event) then      --RESET�� 1�� �� CLK ��� �������� 
            state<= next_state;                     --next state�� ��ȭ
            end if;
    end process;
    
    --outputs, next state
    process(X, state)                           --mealy machine�� ����� �Է°� ���� state�� ���� �ٲ�
    begin
        case state is                           
         when s0 =>
            if X='0' then next_state<=s0; Z<='0';    --s0�� �� X�� 0�̸� next state�� s0, ��� 0
            else next_state<= s1;Z<='0';             --s0�� �� X�� 1�̸� next state�� s1, ��� 0
            end if;
         when s1 =>
            if X='0' then next_state<=s2;Z<='0';   --s1�� �� X�� 0�̸� next state�� s2, ��� 0
            else next_state<= s1;Z<='0';           --s1�� �� X�� 1�̸� next state�� s1, ��� 0
            end if;
         when s2 =>
            if X='0' then next_state<=s0;Z<='0';   --s2�� �� X�� 0�̸� next state�� s0, ��� 0
            else next_state<= s3;Z<='0';           --s2�� �� X�� 1�̸� next state�� s3, ��� 0
            end if;
         when s3 =>
            if X='0' then next_state<=s2;Z<='1';   --s3�� �� X�� 0�̸� next state�� s2, ��� 1
            else next_state<= s1; Z<='0';          --s3�� �� X�� 1�̸� next state�� s1, ��� 0
            end if;
         when others => null;
        end case;
    end process;

end Behavioral;