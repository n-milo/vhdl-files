-- Implements a state machine using four flip-flops and digital logic to transition states.

library ieee;
use ieee.std_logic_1164.all;

entity lab3 is
	port (
		clk, reset_n : in std_logic;
		le : in std_logic;
		ledg3, ledg2, ledg1, ledg0 : out std_logic
	);
end entity;

architecture logic of lab3 is

signal d3, d2, d1, d0 : std_logic;
signal q3, q2, q1, q0 : std_logic;

begin

-- process encompassing all four flip-flops
  
the_flipflops : process (clk, reset_n)
begin
	if (reset_n = '0') then
		q3 <= '1';
		q2 <= '1';
		q1 <= '0';
		q0 <= '0';
	elsif (clk'event and clk = '1') then
		if (le = '1') then
			q3 <= d3;
			q2 <= d2;
			q1 <= d1;
			q0 <= d0;
		end if;
	end if;
end process;

-- combinational functions that generate
-- the new d from the current q

-- d3 <= (not q1 and not q2) or (q2 and not q3);
-- d2 <= not q3 and not q2;
-- d1 <= q3;
-- d0 <= q1 or (q3 and q2);

d3 <= (not q1) and (not q2 or not q3);
d2 <= (q1) and (not q3);
d1 <= q3;
d0 <= (q1 or q2) and (q1 or q3);

-- associate q outputs inside the arch.
-- with the output ports for the LED pins

ledg3 <= q3;
ledg2 <= q2;
ledg1 <= q1;
ledg0 <= q0;

end architecture; -- logic
