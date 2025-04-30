library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_pwm is
end tb_pwm;

architecture sim of tb_pwm is
    constant max_count_bits : integer := 8;
    constant clk_period : time := 10 ns;

    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal duty_in  : unsigned(max_count_bits - 1 downto 0) := (others => '0');
    signal pwm_out  : std_logic;

    component pwm
        generic (
            max_count_bits : positive := 8
        );
        port (
            rst      : in  std_logic;
            clk      : in  std_logic;
            duty_in  : in  unsigned(max_count_bits - 1 downto 0);
            pwm_out  : out std_logic
        );
    end component;

begin

    
    uut: pwm
        generic map (
            max_count_bits => max_count_bits
        )
        port map (
            rst      => rst,
            clk      => clk,
            duty_in  => duty_in,
            pwm_out  => pwm_out
        );

    
    clk_process : process
    begin
        while now < 6 ms loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    
    stim_proc : process
    begin
        rst <= '1';
        wait for 50 ns;
        rst <= '0';

        -- Fade-in
        for step in 0 to 64 loop
            duty_in <= to_unsigned(step, max_count_bits);
            wait for 50 us;
        end loop;

        -- Fade-out
        for step in 64 downto 0 loop
            duty_in <= to_unsigned(step, max_count_bits);
            wait for 50 us;
        end loop;

        

        wait;
    end process;

end sim;