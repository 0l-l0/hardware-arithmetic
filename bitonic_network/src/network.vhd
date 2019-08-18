-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

---------------------------------------------------------------
-- This file use an array of signals to connect the comparators
-- in the right order.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.data_type.all;

entity network is
	port(
		data_in	: in	data_arr;
		data_out	: out	data_arr
	);
	-- temporary vector for the masks on the first level
	constant mask	: std_logic_vector(0 to 3)
						:= "0101";
end network;

architecture network_behav of network is
	-- the array of wires
	type wire_type is array(0 to 4) of data_arr;
	signal wires	: wire_type;
begin
	
	first_level: for a in 0 to 3 generate
		level_1_comp : entity work.comparator
							generic map(mask(a))
							port map(
								d0_in		=> data_in(2*a),
								d1_in		=> data_in(2*a+1),
								d0_out	=> wires(0)(2*a),
								d1_out	=> wires(0)(2*a+1)
							);
	end generate first_level;
	
	second_level: for b in 0 to 1 generate
		s_l_column: for c in 0 to 1 generate
			level_2_1_comp : 	entity work.comparator
									generic map('0')
									port map(
										d0_in		=> wires(b)(c),
										d1_in		=> wires(b)(c+2),
										d0_out	=> wires(b+1)(2*c),
										d1_out	=> wires(b+1)(2*c+1)
									);
			level_2_2_comp : 	entity work.comparator
									generic map('1')
									port map(
										d0_in		=> wires(b)(c+4),
										d1_in		=> wires(b)(c+6),
										d0_out	=> wires(b+1)(2*c+4),
										d1_out	=> wires(b+1)(2*c+5)
									);
		end generate s_l_column;
	end generate second_level;
	
	third_level: for d in 0 to 1 generate
		th_l_column: for e in 0 to 3 generate
			level_3_comp : 	entity work.comparator
									generic map('0')
									port map(
										d0_in		=> wires(d+2)((e+2*d) mod 4),
										d1_in		=> wires(d+2)((e+2*d) mod 4 + 4),
										d0_out	=> wires(d+3)(2*(e+e*d+d) mod 10),
										d1_out	=> wires(d+3)(2*(e+e*d+d) mod 10 + 1)
									);
		end generate th_l_column;
	end generate third_level;
	
	fourth_level: for f in 0 to 1 generate
		level_4_1_comp : entity work.comparator
							generic map('0')
							port map(
								d0_in		=> wires(4)(f),
								d1_in		=> wires(4)(f+2),
								d0_out	=> data_out(2*f),
								d1_out	=> data_out(2*f+1)
							);
		level_4_2_comp : entity work.comparator
							generic map('0')
							port map(
								d0_in		=> wires(4)(f+4),
								d1_in		=> wires(4)(f+6),
								d0_out	=> data_out(2*f+4),
								d1_out	=> data_out(2*f+5)
							);
	end generate fourth_level;

end network_behav;

