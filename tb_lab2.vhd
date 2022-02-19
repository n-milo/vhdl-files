-- Testing logic for lab2.vhd.
-- Outputs all 8 possible combinations for x,y,z,w to test the outputs of lab2.vhd.

library ieee;
use ieee.std_logic_1164.all;

entity tb_lab2 is
-- no external ports/pins
end entity;

architecture testbench of tb_lab2 is

component lab2
  port (w, x, y, z : in  std_logic;
        fsp, fps   : out std_logic);
end component;

signal w, x, y, z, fsp, fps : std_logic;
signal v : std_logic_vector(3 downto 0);

begin

lab2_under_test : lab2
	port map (
			w => w,
        x => x,
        y => y,
        z => z,
        fsp => fsp,
        fps => fps
			 );

test_driver : process
begin
v <= "0000";  wait for 20 ns;
v <= "0001";  wait for 20 ns;
v <= "0010";  wait for 20 ns;
v <= "0011";  wait for 20 ns;
v <= "0100";  wait for 20 ns;
v <= "0101";  wait for 20 ns;
v <= "0110";  wait for 20 ns;
v <= "0111";  wait for 20 ns;
v <= "1000";  wait for 20 ns;
v <= "1001";  wait for 20 ns;
v <= "1010";  wait for 20 ns;
v <= "1011";  wait for 20 ns;
v <= "1100";  wait for 20 ns;
v <= "1101";  wait for 20 ns;
v <= "1110";  wait for 20 ns;
v <= "1111";  wait;
end process;


w <= v(3);
x <= v(2);
y <= v(1);
z <= v(0);

end architecture;

