library ieee;
use ieee.std_logic_1164.all;
library work;
package Compliment is
	component Comp2 is
		port (
			X : in std_logic_vector (15 downto 0);
			Z : out std_logic_vector(15 downto 0)
		);
	end component Comp2;
end package ; 

library ieee;
use ieee.std_logic_1164.all;
entity Comp2 is
	port (
      X : in std_logic_vector(15 downto 0);
      Z : out std_logic_vector(15 downto 0)
	);
end entity Comp2;
architecture arch of Comp2 is
	component adder  is
		port ( a : in std_logic_vector (15 downto 0);
	         b : in std_logic_vector (15 downto 0);
	         sum : out std_logic_vector (15 downto 0)) ;
	end component;

  signal T : std_logic_vector(15 downto 0);
begin

	gen: for i in 0 to 15 generate
			T(i) <= not X(i);
	end generate gen;

	fa: adder
	port map (
			a => T,
			b => "0000000000000001",
			sum => Z
	);

end architecture ; 
library ieee;
use ieee.std_logic_1164.all;
library work;
package MUX is
	component mux4to1 is
		port (
			S  : in std_logic_vector (2 downto 0);
			A5, A6, A7, A8 : in std_logic_vector(15 downto 0) ;
			Z : out std_logic_vector(15 downto 0)
		);
	end component mux4to1;
end package ; 

library ieee;
use ieee.std_logic_1164.all;
entity mux4to1 is
	port (
      S  : in std_logic_vector (2 downto 0);
      A5, A6, A7, A8 : in std_logic_vector(15 downto 0) ;
      Z : out std_logic_vector(15 downto 0)
	);
end entity mux4to1;
architecture arch of mux4to1 is

begin


	genmux: for i in 0 to 15 generate
			Z(i) <= (A5(i) and ((not S(2)) and (S(1) xor S(0)))) or (A6(i) and ((not S(2)) and (S(1) and S(0)))) or (A7(i) and (S(2) and (S(1) xor S(0)))) or (A8(i) and (S(2) and (not (S(1) or S(0)))));
	end generate genmux;
end architecture ; 
library ieee ;
use ieee.std_logic_1164.all;

entity adder is
  port ( a : in std_logic_vector (15 downto 0);
         b : in std_logic_vector (15 downto 0);
         sum : out std_logic_vector (15 downto 0)) ;
end entity ;

architecture Equations of adder is
  signal c : std_logic_vector( 16 downto 0 );

  begin
    c(0 downto 0) <= "0";

    genAdd: for I in 0 to 15 generate
      sum(I) <= a(I) xor b(I) xor c(I);
      c(I+1) <= ((a(I) or b(I)) and c(I)) or (a(I) and b(I));
    end generate genAdd;

  end Equations;
  library ieee;
use ieee.std_logic_1164.all;

package Left_Shift is
	component left2 is
		port (
			X : in std_logic_vector(15 downto 0) ;
			Z : out std_logic_vector(15 downto 0)
		);
	end component left2;
end package ; 

library ieee;
use ieee.std_logic_1164.all;
entity left2 is
	port (
		X : in std_logic_vector(15 downto 0);
		Z : out std_logic_vector(15 downto 0)
	);
end entity left2;
architecture arch of left2 is

begin

	genls: for i in 2 to 15 generate
  		Z(i) <= X(i-2);
	end generate genls;

  Z(1 downto 0) <= "00";

end architecture ; 


