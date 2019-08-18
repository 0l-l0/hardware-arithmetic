-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
	-- here we declare the interface of the ALU
	generic(width	: positive	:= 7);
	port(
		data_0, data_1	: in	std_logic_vector(width downto 0);
		opcode			: in	std_logic_vector(1 downto 0);
		result			: out	std_logic_vector(width downto 0);
		flag				: out	std_logic
	);
end ALU;
-- structural modeling style
architecture ALU_behav of ALU is
	-- we specify the components of the structure
	component shift_left
		generic(width	: positive	:= 7);
		port(
			data_in	: in	std_logic_vector(width downto 0);
			data_out	: out	std_logic_vector(width downto 0);
			flag		: out	std_logic
		);
	end component;
	
	component add
		generic(width	: positive	:= 7);
		port(
			data_0, data_1	: in	std_logic_vector(width downto 0);
			data_out			: out	std_logic_vector(width downto 0);
			flag				: out	std_logic
		);
	end component;
	
	component and_module
		generic(width	: positive	:= 7);
		port(
			data_0, data_1	: in	std_logic_vector(width downto 0);
			data_out			: out	std_logic_vector(width downto 0)
		);
	end component;
	
	component or_module
		generic(width	: positive	:= 7);
		port(
			data_0, data_1	: in	std_logic_vector(width downto 0);
			data_out			: out	std_logic_vector(width downto 0)
		);
	end component;
	
	component switch
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
	end component;
	-- the signals that connect the parts
	signal	shl_d_sig,
				add_d_sig,
				and_sig,
				or_sig		: std_logic_vector(width downto 0);
				
	signal	shl_f_sig,
				add_f_sig	: std_logic;
	
begin
	-- instantiation of the components
	comp_0 : shift_left	generic map(width => width)
								port map(
									data_in	=> data_0,
									data_out	=> shl_d_sig,
									flag		=> shl_f_sig
								);
								
	comp_1 : add	generic map(width => width)
						port map(
							data_0	=> data_0,
							data_1	=> data_1,
							data_out	=> add_d_sig,
							flag		=> add_f_sig
						);
								
	comp_2 : and_module	generic map(width => width)
								port map(
									data_0	=> data_0,
									data_1	=> data_1,
									data_out	=> and_sig
								);
								
	comp_3 : or_module	generic map(width => width)
								port map(
									data_0	=> data_0,
									data_1	=> data_1,
									data_out	=> or_sig
								);
								
	comp_4 : switch	generic map(width => width)
							port map(
								data_0	=> shl_d_sig,
								data_1	=> add_d_sig,
								data_2	=> and_sig,
								data_3	=> or_sig,
								flag_0	=> shl_f_sig,
								flag_1	=> add_f_sig,
								opcode	=> opcode,
								data_out	=> result,
								flag_out	=> flag
							);

end ALU_behav;
