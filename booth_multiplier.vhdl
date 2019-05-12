library ieee;
use ieee.std_logic_1164.all;

entity Booth is
	port (
		IN1 , IN2 : in std_logic_vector(7 downto 0);
		Z : out std_logic_vector(15 downto 0)
	);
end entity Booth;

architecture arch of Booth is

	component Comp2 is
		port (
			X : in std_logic_vector (15 downto 0);
			Z : out std_logic_vector(15 downto 0)
		);
	end component;

	component adder is
	  port ( a : in std_logic_vector (15 downto 0);
	         b : in std_logic_vector (15 downto 0);
	         sum : out std_logic_vector (15 downto 0)) ;
	end component ;

	component mux4to1 is
		port (
			S  : in std_logic_vector (2 downto 0);
			A5, A6, A7, A8 : in std_logic_vector(15 downto 0) ;
			Z : out std_logic_vector(15 downto 0)
		);
	end component;

	component left2 is
		port (
			X : in std_logic_vector(15 downto 0) ;
			Z : out std_logic_vector(15 downto 0)
		);
	end component;

	signal A1,A2,A3,A4,A5,A6,A7,A8  : std_logic_vector(15 downto 0) ;
	signal init: std_logic_vector(2 downto 0);
	signal A9 : std_logic_vector(8 downto 0) ;
	signal A12 : std_logic_vector(7 downto 0) ;
	constant A10 : std_logic_vector(15 downto 0)  := (others  => '0');
	constant A11 : std_logic_vector(7 downto 0)  := (others  => '0');
	
	signal partials_product0, partial_product1, partial_product2 , partial_product3, partial_product4, partial_product5, partial_product6, partial_product7, partial_product8, partial_product9, partial_product10 : std_logic_vector(15 downto 0) ;

begin

	A1(15 downto 8) <= A11;
	A1(7 downto 0) <= IN1;
   A12(7) <= IN1(7);
	A12(6) <= IN1(7);
	A12(5) <= IN1(7);
	A12(4) <= IN1(7);
	A12(3) <= IN1(7);
	A12(2) <= IN1(7);
	A12(1) <= IN1(7);
	A12(0) <= IN1(7);
	
	A5(15 downto 8) <= A12(7 downto 0);
	A5(7 downto 0) <= IN1;

	A6(15 downto 9) <= A12(6 downto 0);
	A6(8 downto 1) <= IN1;
	A6(0 downto 0) <= "0";
	A3(15 downto 8) <= A6(7 downto 0);
   A3(7 downto 1)  <= A5(7 downto 1);
	A3(0 downto 0) <="0"; 
	C0 : Comp2
	 	port map(X => A5, Z => A7);

	A8(15 downto 1) <= A7(14 downto 0);
	A8(0 downto 0) <= "0";
	A4(15 downto 0) <= A8(15 downto 0);

	init(2 downto 1) <= "01";
	init(0) <= IN2(7);
	A9(8 downto 1) <= IN2;
	A9(0 downto 0) <= "0";
	A2(15 downto 0) <= A8;
	
	

	a : mux4to1
		port map(A9(8 downto 6), A5, A6, A7, A8, partial_product1);

	b  : adder
		port map(partial_product1, A10, partial_product2);

	c: left2
		port map(partial_product2, partial_product3);

	d : mux4to1
		port map(A9(6 downto 4), A5, A6, A7, A8, partial_product4);

	e  : adder
		port map(partial_product4, partial_product3, partial_product5);

	f : left2
		port map(partial_product5, partial_product6);

	g : mux4to1
		port map(A9(4 downto 2), A5, A6, A7, A8, partial_product7);

	h  : adder
		port map(partial_product7, partial_product6, partial_product8);

	i : left2
		port map(partial_product8, partial_product9);

	j : mux4to1
		port map(A9(2 downto 0), A5, A6, A7, A8, partial_product10);

	k  : adder
		port map(partial_product9, partial_product10, Z);

	-- lsf3 : left2
	-- 	port map(partial_product11, Z);



end architecture ; -- arch
