-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity redundant_array is

	-- here we declare the interface of the adder
	generic(
		width	: positive	:= 8
	);
	port(
		first, second	: in	std_logic_vector(width-1 downto 0);
		result			: out	std_logic_vector(width downto 0)
	);
	
end redundant_array;

----------------------------------------------------------------------
----------------------------------------------------------------------

architecture red_arr_behav of redundant_array is

	-- signal between first and second level
	signal 	part_sum		: std_logic_vector(2*width-2 downto 0);
	
	-- this signals contain the redundant forms of the given numbers
	signal 	number_0,
				number_1		: std_logic_vector(2*width-1 downto 0);
				
	-- the result of the redundant addition
	signal	total_sum	: std_logic_vector(2*width+1 downto 0)	:= (others => '0');
	
	-- just a simple carry signal for the backward conversion
	signal	carry			: std_logic_vector(width-1 downto 0);
	
begin

	-- here we convert the first and the second numbers to redundant form
	to_redundant: for R in 0 to width-2 generate
		number_0(2*R)		<= first(R);
		number_0(2*R+1)	<= '1';
		number_1(2*R)		<= second(R);
		number_1(2*R+1)	<= '1';
	end generate to_redundant;
	number_0(2*width-2)	<= first(width-1);
	number_0(2*width-1)	<= '0';
	number_1(2*width-2)	<= second(width-1);
	number_1(2*width-1)	<= '0';
	
	----------------------------------------------------------------------
	----------------------------------------------------------------------
	
	-- the implementation of the first level
	first_level: for S in 0 to width-2 generate
		first_level_add: entity work.full_adder port map(
			number_0(S*2),
			number_0(S*2+1),
			number_1(S*2+1),
			part_sum(S*2),
			part_sum(S*2+1)
		);
	end generate first_level;
	
	-- the last full_adder on the first level
	add1: entity work.full_adder port map(
		number_0(2*width-2),
		number_0(2*width-1),
		number_1(2*width-1),
		part_sum(2*width-2),
		total_sum(2*width+1)
	);
	
	-- the fisrt full_adder on the second level
	add2: entity work.full_adder port map(
		number_1(0),
		part_sum(0),
		'1',
		total_sum(1),
		total_sum(2)
	);
	
	-- the implementation of the second level
	second_level: for T in 1 to width-1 generate
		second_level_add: entity work.full_adder port map(
			number_1(T*2),
			part_sum(T*2),
			part_sum(T*2-1),
			total_sum(T*2+1),
			total_sum((T+1)*2)
		);
	end generate second_level;
	
	----------------------------------------------------------------------
	----------------------------------------------------------------------
	
	-- here we convert the numbers back to the two's complement form
	
	-- the first full_adder
	add3: entity work.full_adder port map(
		total_sum(0),
		total_sum(1),
		'1',
		result(0),
		carry(0)
	);
	
	-- a simple ripple carry reconverter
	reconv_level: for U in 1 to width-1 generate
		reconv_level_add: entity work.full_adder port map(
			total_sum(2*U),
			total_sum(2*U+1),
			carry(U-1),
			result(U),
			carry(U)
		);
	end generate reconv_level;
	
	-- the last full_adder
	add4: entity work.full_adder port map(
		'1',
		'0',
		carry(width-1),
		result(width),
		open
	);

end red_arr_behav;
