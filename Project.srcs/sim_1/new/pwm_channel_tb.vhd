library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_channel_tb is
end pwm_channel_tb;

architecture tb of pwm_channel_tb is

    component pwm_channel
        port (
            clk        : in std_logic;
            reset      : in std_logic;
            duty_cycle : in std_logic_vector (7 downto 0);
            pwm_out    : out std_logic
        );
    end component;

    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal duty_cycle : std_logic_vector (7 downto 0) := (others => '0');
    signal pwm_out    : std_logic;

    constant TbPeriod : time := 10 ns;  -- 100 MHz clock
    signal TbSimEnded : std_logic := '0';

begin

    -- Instance of DUT (Device Under Test)
    dut : pwm_channel
        port map (
            clk        => clk,
            reset      => reset,
            duty_cycle => duty_cycle,
            pwm_out    => pwm_out
        );

    -- Clock generation
    clk_process : process
    begin
        while TbSimEnded = '0' loop
            clk <= '1';
            wait for TbPeriod / 2;
            clk <= '0';
            wait for TbPeriod / 2;
        end loop;
        wait;
    end process;

  -- Stimuli
stimuli : process
begin
    -- Reset
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 20 ns;

    -- Test 25 % duty cycle (64)
    duty_cycle <= x"40";
    wait for 3000 ns;

    -- Test 50 % duty cycle (128)
    duty_cycle <= x"80";
    wait for 3000 ns;

    -- Test 75 % duty cycle (192)
    duty_cycle <= x"C0";
    wait for 3000 ns;

    -- Test 100 % duty cycle (255)
    duty_cycle <= x"FF";
    wait for 3000 ns;

    -- Test 0 % duty cycle (0)
    duty_cycle <= x"00";
    wait for 3000 ns;

    -- End simulation
    TbSimEnded <= '1';
    wait;
end process;

end tb;

configuration cfg_pwm_channel_tb of pwm_channel_tb is
    for tb
    end for;
end cfg_pwm_channel_tb;