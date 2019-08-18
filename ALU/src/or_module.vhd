-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_module is
	generic(width	: positive	:= 7);
	port(
		data_0, data_1	: in	std_logic_vector(width downto 0);
		data_out			: out	std_logic_vector(width downto 0)
	);
end or_module;

-- dataflow modeling style
architecture or_module_behav of or_module is
begin
	data_out	<= data_0 or data_1;
end or_module_behav;
