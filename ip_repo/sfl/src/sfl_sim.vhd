----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2024 01:59:16 AM
-- Design Name: 
-- Module Name: sfl_sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sfl_sim is
--  Port ( );
end sfl_sim;

architecture Behavioral of sfl_sim is
    signal led : std_logic_vector(3 downto 0);
    signal rst : std_logic;
    signal cnt : std_logic_vector(23 downto 0);
begin
    dut: entity work.sfl port map(clk => cnt(0), reset => rst, leds => led);
    
    stimulus:
    process begin
        rst <= '1';
        wait for 10ns;
        rst <= '0';
        wait for 10ns;
        for i in 0 to 8 loop
            cnt <= (others => '0');
            while cnt/="111111111111111111111111" loop
                cnt <= std_logic_vector(unsigned(cnt) + 1);
                wait for 10ns;
                cnt <= std_logic_vector(unsigned(cnt) + 1);
                wait for 10ns;
            end loop;
        end loop;
    end process;


end Behavioral;
