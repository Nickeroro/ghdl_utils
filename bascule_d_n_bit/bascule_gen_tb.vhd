-----------------------------------------------------------------
-- This file was generated automatically by vhdl_tb Ruby utility
-- date : (d/m/y) 02/05/2019 15:33
-- Author : Jean-Christophe Le Lann - 2014
-----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bascule_gen_tb is
end entity;

architecture bhv of bascule_gen_tb is
  constant n : natural := 4;
  constant HALF_PERIOD : time := 5 ns;

  signal clk     : std_logic := '0';
  signal reset_n : std_logic := '0';
  signal sreset  : std_logic := '0';
  signal running : boolean   := true;

  procedure wait_cycles(n : natural) is
   begin
     for i in 1 to n loop
       wait until rising_edge(clk);
     end loop;
   end procedure;

  --signal clk    : std_logic;
  signal reset  : std_logic;
  signal ENTREE : std_logic_vector(N - 1 downto 0);
  signal SORTIE : std_logic_vector(N - 1 downto 0);

begin
  -------------------------------------------------------------------
  -- clock and reset
  -------------------------------------------------------------------
  reset_n <= '0','1' after 20 ns;

  clk <= not(clk) after HALF_PERIOD when running else clk;

  --------------------------------------------------------------------
  -- Design Under Test
  --------------------------------------------------------------------
  dut : entity work.bascule_gen(rtl)
        generic map(
          N => 4)
        port map (
          clk    => clk   ,
          reset  => reset ,
          ENTREE => ENTREE,
          SORTIE => SORTIE
        );

  --------------------------------------------------------------------
  -- sequential stimuli
  --------------------------------------------------------------------
  stim : process
   begin
     report "running testbench for dff(using_rising_edge)";
     report "waiting for asynchronous reset";
     wait until reset_n='1';
     wait_cycles(1);
     report "applying stimuli...";
     ENTREE <= "0001";
     wait_cycles(3);
     report "applying stimuli...";
     ENTREE <= "0010";
     wait_cycles(2);
     report "applying stimuli...";
     ENTREE <= "0110";
     wait_cycles(4);
     report "applying stimuli...";
     ENTREE <= "1011";
     wait_cycles(3);
     report "end of simulation";
     running <=false;
     wait;
   end process;

end bhv;
