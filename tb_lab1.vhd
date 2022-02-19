-- Testing logic for lab1.vhd.
-- Outputs all 8 possible combinations for x,y,z to test the outputs of lab1.vhd.

library ieee;
use ieee.std_logic_1164.all;

entity tb_lab1 is

end entity;


architecture testbench of tb_lab1 is

component lab1
  port (x, y, z : in  std_logic;
        f       : out std_logic);
end component;

for all: lab1 use entity work.lab1(pos);

signal x, y, z, f : std_logic;

begin

lab1_under_test : lab1
	port map (
			  x => x,
			  y => y,
			  z => z,
			  f => f
			 );

test_driver : process
begin
  x <= '0';  y <= '0';  z <= '0';  wait for 20 ns;
  x <= '0';  y <= '0';  z <= '1';  wait for 20 ns;
  x <= '0';  y <= '1';  z <= '0';  wait for 20 ns;
  x <= '0';  y <= '1';  z <= '1';  wait for 20 ns;
  x <= '1';  y <= '0';  z <= '0';  wait for 20 ns;
  x <= '1';  y <= '0';  z <= '1';  wait for 20 ns;
  x <= '1';  y <= '1';  z <= '0';  wait for 20 ns;
  x <= '1';  y <= '1';  z <= '1';  wait;
end process;

end architecture;

