-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

---------------------------------------------------------------------
-- In this file I wrote a test bench for my bitonic sorter network.
-- I loaded 8 constant numbers into the network in "data_arr" format.
-- I declared a signal for the sorted array of the numbers I gave to
-- the sorter.
-- In architecture body I instantiated a test_network and a process
-- that write out the result of the work.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.data_type.all;

entity sort_test is
	-- empty entity block for the simulation
end sort_test;

architecture sort_test_behav of sort_test is
	-- the array of unsorted numbers
	constant data	: data_arr	:= (
		"01110010",	-- 114
		"00010111",	-- 23
		"00101010",	-- 42
		"11001111",	-- 207
		"00000011",	-- 3
		"01001100",	-- 76
		"10001011",	-- 139
		"00110011"	-- 51
	);
	-- the signal for sorted numbers
	signal sorted	: data_arr;
	
begin
	-- network instantiation
	test_network: entity work.network port map(
		data_in	=>	data,
		data_out	=>	sorted
	);
	-- the process to show the result
	write_out : process
	begin
		
		wait on sorted;
		wait for 1 ps;
		
		for i in sorted'range loop
			report integer'image(to_integer(unsigned(sorted(i))));
		end loop;
		
	end process write_out;
	
end sort_test_behav;

