-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
	port(
		first_bit, second_bit, carry_in	: in	std_logic;
		sum, carry_out							: out	std_logic
	);
end full_adder;

architecture full_adder_behav of full_adder is
begin
	sum			<=	first_bit xor second_bit xor carry_in;
	carry_out	<=	(first_bit and second_bit)	or
						(first_bit and carry_in)	or
						(second_bit and carry_in);
end full_adder_behav;
