-- Implements an arbitrary state machine using flip-flops, and both low-level
-- digital logic to decide the next flip-flop register values, and high-level
-- VHDL process code to determine the next state. Also writes the current
-- state to the DE0's built-in 7-segment LED display.

library ieee;
use ieee.std_logic_1164.all;

entity lab4 is
	port (
		clk, reset_n : in  std_logic;
		a, b         : in  std_logic;   -- primary inputs
		w_gl, x_gl   : out std_logic;   -- gate-level fsm primary outputs
		q1_gl, q0_gl : out std_logic;   -- gate-level fsm state-bit outputs
		w_hl, x_hl   : out std_logic;    -- high-level fsm primary outputs
		hex_out		 : out std_logic_vector(6 downto 0)
	);
end entity;

architecture combined of lab4 is

-- for gate-level specification:

-- define internal signals q0, q1, ... for individual state flip-flop outputs
signal q0, q1 : std_logic;

-- define internal signals d0, d1, ... for individual state flip-flop inputs
signal d0, d1 : std_logic;


-- for high-level spec:

-- define state type and signal
type state_type is (F, H, J, L);
signal state : state_type;

signal hex : std_logic_vector(6 downto 0);

begin


-- for gate-level spec:

the_state_dffs: process (clk, reset_n)
begin
	if (reset_n = '0') then
		q1 <= '0';
		q0 <= '0';
	elsif (clk'event and clk = '1') then
		q1 <= d1;
		q0 <= d0;
	end if;
end process;

-- assignment for next-state d0, d1, ... functions
d1 <= (not q1 and q0) or (q1 and not q0) or (q1 and q0 and not b) or (not q0 and not a and b);
d0 <= (not q1 and q0) or (q1 and not q0) or (q1 and q0 and not b) or (not a and not b);

-- assignment for gate-level fsm primary output functions
w_gl <= (q1 and not q0) or (not q1 and q0);
x_gl <= q0 or q1;

-- assignment for gate-level fsm state-bit outputs
q1_gl <= q1;
q0_gl <= q0;

hex <= "1110001" when (state = F)
		else "1110110" when (state = H)
		else "0011110" when (state = J)
		else "0111000";
		
hex_out <= not hex;

-- for high-level spec:

the_fsm : process (clk, reset_n)
begin
	if (reset_n = '0') then
		state <= F;
	elsif (clk'event and clk = '1') then
		case (state) is
		
			when F =>
				if (a = '1') then state <= F;
				elsif (a = '0' and b = '0') then state <= H;
				elsif (a = '0' and b = '1') then state <= J;
				end if;
			
			when J => state <= L;
			
			when H => state <= L;
			
			when L =>
				if (b = '0') then state <= L;
				elsif (b = '1') then state <= F;
				end if;
				
		end case;
	end if;
end process;

-- assignment with when...else... syntax to specify behaviour of high-level fsm outputs
w_hl <= '1' when (state = H or state = J) else '0';
x_hl <= '0' when (state = F) else '1';

end architecture ; -- combined