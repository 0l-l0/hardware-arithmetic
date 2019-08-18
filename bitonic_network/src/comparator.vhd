-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

-----------------------------------------------------------------------
-- This file describes the behaviour of every comparator in the network.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.data_type.all;

entity comparator is
	-- generic mask to alter the behaviour
	generic(
		mask	: std_logic	:= '0'
	);
	port(
		d0_in, d1_in	: in	std_logic_vector(width-1 downto 0);
		d0_out, d1_out	: out	std_logic_vector(width-1 downto 0)
	);
end comparator;

architecture comp_behav of comparator is
begin
	d0_out	<= d0_in when	d0_in=d1_in						or
									(mask='0' and d0_in<d1_in)	or
									(mask='1' and d0_in>d1_in)
							else d1_in;
							
	d1_out	<= d1_in when	d0_in=d1_in						or
									(mask='0' and d0_in<d1_in)	or
									(mask='1' and d0_in>d1_in)
							else d0_in;
end comp_behav;

