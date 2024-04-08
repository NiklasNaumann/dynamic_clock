----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2024 01:33:24 AM
-- Design Name: 
-- Module Name: sfl - Behavioral
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
use IEEE.std_logic_signed.all;
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sfl is
    generic(
        num_leds : integer := 4;
        std_clk_rate : integer := 100000000;
        blinks_per_sec : integer := 4
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        led : out std_logic_vector(num_leds-1 downto 0)
    );
end sfl;

architecture Behavioral of sfl is
    constant max_val : integer := std_clk_rate/blinks_per_sec;
    constant cnt_bits : integer := integer(ceil(log2(real(max_val))));

    signal shift : std_logic;
    signal cnt : std_logic_vector(cnt_bits-1 downto 0) := (others => '0');
    signal led_tmp : std_logic_vector(num_leds-1 downto 0);
begin
    counter:
    process(reset, clk) begin
        if(reset='0') then
            shift <= '0';
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if(cnt=max_val) then
                cnt <= (others => '0');
                shift <= '1';
            else
                cnt <= cnt + 1; --std_logic_vector(unsigned(cnt) + 1);
                shift <= '0';
            end if;
        end if;
    end process;
    
    sreg:
    process(reset, clk) begin
        if(reset='0') then
            led_tmp <= (others => '0');
            led_tmp(0) <= '1';
        elsif rising_edge(clk) then
            if(shift='1') then
                led_tmp <= led_tmp(num_leds-2 downto 0) & led_tmp(num_leds-1);
            end if;
        end if;
    end process;
    
    led <= led_tmp;

end Behavioral;
