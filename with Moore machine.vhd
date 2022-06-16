Copyright 2022. (Hyeonsu Lee) All rights reserved. 
    
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seq_Detector_Moore_tb is
end Seq_Detector_Moore_tb;

architecture Behavioral of Seq_Detector_Moore_tb is
    component Seq_Detector_Moore is         --설계한 시퀀스 디텍터를 불러와서 스펙에 맞게 동작하는지 확인
    port(                                   --시퀀스 디텍터의 입력과 출력 그대로
    CLK: in std_logic;
    RESET: in std_logic;
    X: in std_logic;
    Z: out std_logic);
    end component;
    
    signal CLK :std_logic;       
    signal RESET: std_logic;
    signal X,Z: std_logic;
    
begin
    --테스트벤치와 설계한 시퀀스 디텍터의 입력과 출력 연결
    SD: Seq_Detector_Moore port map(CLK=>CLK, RESET=>RESET, X=>X, Z=>Z);
    
    rst_operation :process  --reset이 0일 때 초기 상태로 돌아가는지 확인하기 위함
    begin
    RESET <= '0';
    wait for 15ns;
    RESET <= '1';
    wait for 80ns;
    RESET <= '0';
    wait for 10ns;
    RESET<= '1';
    wait;
    end process;
    
    clk_operation : process    --클락을 인가하기 위함
    begin
    CLK<='1';
    wait for 5ns;
     CLK<='0';
    wait for 5ns;
    end process;
    
    input_operation : process       --출력이 잘 나오는지 확인하기 위한 입력 인가
    begin
    X<='1';
    wait for 25ns;
    X<='0';
    wait for 10ns;
    X<='1';
    wait for 10ns;
    X<='0';
    wait for 10ns;
    X<='1';
    wait for 10ns;
    X<='0';
    wait for 10ns;
    X<='1';
    wait for 10ns;
    X<='0';
    wait for 10ns;
    X<='1';
    wait for 10ns;
    X<='0';
    wait for 10ns;
    X<='1';
    wait for 10ns;
    X<='0';
    wait for 10ns;
    X<='1';
    wait for 10ns;
    X<='0';
    wait;
    end process;
end Behavioral;
