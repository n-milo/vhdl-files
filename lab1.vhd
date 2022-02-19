-- Implements an arbitrary logical function of variables x,y,z,
-- in both sum-of-products form and product-of-sums form

library ieee;
use ieee.std_logic_1164.all;

entity lab1 is
      port (x, y, z : in  std_logic;
           f       : out std_logic);
end entity;

architecture sop of lab1 is
begin

f <=     (not x and not y and     z)
      or (not x and     y and     z)
      or (    x and not y and     z)
      or (    x and     y and not z)
      or (    x and     y and     z);

end architecture;

architecture pos of lab1 is
begin

f <=      (    x or     y or     z)
      and (    x or not y or     z)
      and (not x or     y or     z);

end architecture;