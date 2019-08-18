-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_left is
	generic(width	: positive	:= 7);
	port(
		data_in	: in	std_logic_vector(width downto 0);
		data_out	: out	std_logic_vector(width downto 0);
		flag		: out	std_logic
	);
end shift_left;

-- dataflow modeling style
architecture shl_behav of shift_left is
begin
	data_out(width downto 1)	<=	data_in(width-1 downto 0);
	data_out(0)						<=	'0';
	flag								<=	data_in(width);
end shl_behav;
