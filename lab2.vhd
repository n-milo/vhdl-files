-- Implements an arbitrary logical function of variables x,y,z,w.
-- Outputs both sum-of-products form and product-of-sums form.

library ieee;
use ieee.std_logic_1164.all;

entity lab2 is
	port (w, x, y, z : in  std_logic;
		   fsp, fps   : out std_logic);
end entity;

architecture sop of lab2 is

begin

fsp <= (not w and z) or (x and y) or (w and not x and not y) or (w and not x and not z);
fps <= (w or x or z) and (not w or x or not y or not z) and (not x or y or z) and (not w or not x or y);

end architecture;