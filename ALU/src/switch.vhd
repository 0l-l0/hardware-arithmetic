-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity switch is
	generic(width	: positive	:= 7);
	port(
		data_0,
		data_1,
		data_2,
		data_3	: in	std_logic_vector(width downto 0);
		flag_0,
		flag_1	: in	std_logic;
		opcode	: in	std_logic_vector(1 downto 0);
		data_out	: out	std_logic_vector(width downto 0);
		flag_out	: out	std_logic
	);
end switch;


-- behavioral modeling style
architecture switch_behav of switch is
begin

	process(data_0, data_1, data_2, data_3, flag_0, flag_1, opcode)
	begin
		-- the state of the opcode pins choose the right operation
		case opcode is
			when "00" =>	data_out	<= data_0;
								flag_out	<= flag_0;
								
			when "01" =>	data_out	<= data_1;
								flag_out	<= flag_1;
								
			when "10" =>	data_out	<= data_2;
								flag_out	<= '0';
								
			when "11" =>	data_out	<= data_3;
								flag_out	<= '0';
								
			when others =>	null;
		end case;
	end process;
	
end switch_behav;
