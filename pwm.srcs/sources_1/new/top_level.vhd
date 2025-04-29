library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port (
        CLK100MHZ : in  std_logic;
        BTNC      : in  std_logic;
        BTNU      : in  std_logic;
        BTND      : in  std_logic;
        SW        : in  std_logic_vector(5 downto 0);

        LED16_R   : out std_logic;
        LED16_G   : out std_logic;
        LED16_B   : out std_logic;
        LED17_R   : out std_logic;
        LED17_G   : out std_logic;
        LED17_B   : out std_logic;

        LED       : out std_logic_vector(0 downto 0)  -- LED[0] PWM
    );
end top_level;

architecture Structural of top_level is

    signal pwm_outs : std_logic_vector(5 downto 0);

    component controller
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
    end component;

begin

    u_controller : controller
        port map (
            clk        => CLK100MHZ,
            rst        => BTNC,
            sw         => SW,
            btnc       => BTNC,
            btnu       => BTNU,
            btnd       => BTND,
            pwm_outs   => pwm_outs,
            debug_pwm  => LED(0)
        );

   
    LED16_R <= pwm_outs(0);
    LED16_G <= pwm_outs(1);
    LED16_B <= pwm_outs(2);
    LED17_R <= pwm_outs(3);
    LED17_G <= pwm_outs(4);
    LED17_B <= pwm_outs(5);

end Structural;