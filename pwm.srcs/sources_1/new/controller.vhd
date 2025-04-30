library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controller is
    Port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        sw         : in  std_logic_vector(5 downto 0);
        btnc       : in  std_logic;
        btnu       : in  std_logic;
        btnd       : in  std_logic;
        pwm_outs   : out std_logic_vector(5 downto 0);
        debug_pwm  : out std_logic
    );
end controller;

architecture Behavioral of controller is

    constant max_count_bits : integer := 8;
    constant DUTY_MAX_LIMIT : unsigned(max_count_bits - 1 downto 0) := to_unsigned(255, 8);
    signal max_duty   : unsigned(max_count_bits - 1 downto 0) := to_unsigned(64, 8);

    signal duty       : unsigned(max_count_bits - 1 downto 0) := (others => '0');
    signal direction  : std_logic := '1';
    signal pwm_raw    : std_logic_vector(5 downto 0);

    -- Prescaler to slow down brightness changes
    signal prescaler       : unsigned(21 downto 0) := (others => '0'); -- range 0 to 4,194,303
    constant PRESCALER_MAX : unsigned(21 downto 0) := to_unsigned(3_900_000, 22); -- cca. 39 ms

    component pwm
        generic (max_count_bits : positive := 8);
        port (
            rst      : in std_logic;
            clk      : in std_logic;
            duty_in  : in unsigned(max_count_bits - 1 downto 0);
            pwm_out  : out std_logic
        );
    end component;

begin

    -- 6× PWM
    pwm_inst : for i in 0 to 5 generate
        pwm_gen : pwm
            generic map (max_count_bits => max_count_bits)
            port map (
                rst     => rst,
                clk     => clk,
                duty_in => duty,
                pwm_out => pwm_raw(i)
            );
    end generate;

    -- Fade-in / fade-out using prescaler for speed control
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' or btnc = '1' then
                duty <= (others => '0');
                direction <= '1';
                prescaler <= (others => '0');
            else
                if prescaler = PRESCALER_MAX then
                    prescaler <= (others => '0');
                    if direction = '1' then
                        if duty >= max_duty then
                            direction <= '0';
                            duty <= duty - 1;
                        else
                            duty <= duty + 1;
                        end if;
                    else
                        if duty = 0 then
                            direction <= '1';
                            duty <= duty + 1;
                        else
                            duty <= duty - 1;
                        end if;
                    end if;
                else
                    prescaler <= prescaler + 1;
                end if;
            end if;
        end if;
    end process;

    -- Changing max brightness by buttons
    process(clk)
    begin
        if rising_edge(clk) then
            if btnu = '1' and max_duty < DUTY_MAX_LIMIT then
                max_duty <= max_duty + 1;
            elsif btnd = '1' and max_duty > 0 then
                max_duty <= max_duty - 1;
            end if;
        end if;
    end process;

    -- switches PWM output control
    process(sw, pwm_raw)
    begin
        for i in 0 to 5 loop
            if sw(i) = '1' then
                pwm_outs(i) <= pwm_raw(i);
            else
                pwm_outs(i) <= '0';
            end if;
        end loop;
    end process;

    -- Debug output LED[0]
    debug_pwm <= pwm_raw(0);

end Behavioral;