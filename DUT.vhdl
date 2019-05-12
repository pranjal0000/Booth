-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  Full-adder.

library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(15 downto 0);
       	output_vector: out std_logic_vector(15 downto 0));
end entity;

architecture DutWrap of DUT is
   component Booth is
     port (
   		IN1 , IN2 : in std_logic_vector(7 downto 0);
   		Z : out std_logic_vector(15 downto 0)
   	);
   end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: Booth
			port map (
					-- order of inputs Cin B A
          IN1 => input_vector(15 downto 8),
          IN2 => input_vector(7 downto 0),
					Z => output_vector
        );

end DutWrap;
