-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity add is
	generic(width	: positive	:= 7);
	port(
		data_0, data_1	: in	std_logic_vector(width downto 0);
		data_out			: out	std_logic_vector(width downto 0);
		flag				: out	std_logic
	);
end add;


-- mixed modeling style(structural and dataflow)
architecture add_behav of add is

	signal carry : std_logic_vector(width+1 downto 0) := (others => '0');
	
	component full_adder
		port(
			first_bit, second_bit, carry_in	: in	std_logic;
			sum, carry_out							: out	std_logic
		);
	end component;
	
begin

	flag <= carry(width+1);
	-- here we use for-generate statement
	with_width : for i in width downto 0 generate
		digit : 	full_adder port map(
						data_0(i),
						data_1(i),
						carry(i),
						data_out(i),
						carry(i+1)
					);
	end generate;
	
end add_behav;
