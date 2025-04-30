library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm is
    generic (max_count_bits : positive := 8);
    port (
        rst      : in  std_logic;
        clk      : in  std_logic;
        duty_in  : in  unsigned(max_count_bits - 1 downto 0);
        pwm_out  : out std_logic
    );
end pwm;

architecture Behavioral of pwm is

    signal sig_count    : unsigned(max_count_bits - 1 downto 0) := (others => '0');
    signal sig_pwm_out  : std_logic := '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                sig_count    <= (others => '0');
                sig_pwm_out  <= '0';
            else
                sig_count <= sig_count + 1;
                if sig_count < duty_in then
                    sig_pwm_out <= '1';
                else
                    sig_pwm_out <= '0';
                end if;
            end if;
        end if;
    end process;

    pwm_out <= sig_pwm_out;

end Behavioral;