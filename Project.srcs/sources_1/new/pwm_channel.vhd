----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2025 13:34:08
-- Design Name: 
-- Module Name: pwm_channel - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_channel is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           duty_cycle : in STD_LOGIC_VECTOR (7 downto 0);
           pwm_out : out STD_LOGIC);
end pwm_channel;

architecture Behavioral of pwm_channel is
    signal counter : unsigned(7 downto 0) := (others => '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    pwm_out <= '1' when counter < unsigned(duty_cycle) else '0';

end Behavioral;
