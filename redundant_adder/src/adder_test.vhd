-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_test is

	-- here we can set the word_length value
	constant	word_length	:	positive	:= 8;
	
end adder_test;

----------------------------------------------------------------------
----------------------------------------------------------------------

architecture add_test_behav of adder_test is

	-- the first test-number
	constant	num_0	: std_logic_vector(word_length-1 downto 0)
		:="01101101";
		
	-- the second test-number
	constant	num_1	: std_logic_vector(word_length-1 downto 0)
		:="00111010";
		
	-- the signal to read the sum
	signal	sum	: std_logic_vector(word_length downto 0);
	
begin

	-- adder instantiation
	test_adder: entity work.redundant_array
	generic map(word_length)
	port map(
		first		=> num_0,
		second	=> num_1,
		result	=> sum
	);
	
end add_test_behav;
