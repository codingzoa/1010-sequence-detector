
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seq_Detector_Moore_tb is
end Seq_Detector_Moore_tb;

architecture Behavioral of Seq_Detector_Moore_tb is
    component Seq_Detector_Moore is         --������ ������ �����͸� �ҷ��ͼ� ���忡 �°� �����ϴ��� Ȯ��
    port(                                   --������ �������� �Է°� ��� �״��
    CLK: in std_logic;
    RESET: in std_logic;
    X: in std_logic;
    Z: out std_logic);
    end component;
    
    signal CLK :std_logic;       
    signal RESET: std_logic;
    signal X,Z: std_logic;
    
begin
    --�׽�Ʈ��ġ�� ������ ������ �������� �Է°� ��� ����
    SD: Seq_Detector_Moore port map(CLK=>CLK, RESET=>RESET, X=>X, Z=>Z);
    
    rst_operation :process  --reset�� 0�� �� �ʱ� ���·� ���ư����� Ȯ���ϱ� ����
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
    
    clk_operation : process    --Ŭ���� �ΰ��ϱ� ����
    begin
    CLK<='1';
    wait for 5ns;
     CLK<='0';
    wait for 5ns;
    end process;
    
    input_operation : process       --����� �� �������� Ȯ���ϱ� ���� �Է� �ΰ�
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