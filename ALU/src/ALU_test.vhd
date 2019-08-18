-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU_test is
	-- here we can set the word_length for the testcase
	constant word_length	: positive	:= 7;
end ALU_test;


architecture ALU_test_behav of ALU_test is

	component ALU
		generic(width	: positive	:= 7);
		port(
			data_0, data_1	: in	std_logic_vector(width downto 0);
			opcode			: in	std_logic_vector(1 downto 0);
			result			: out	std_logic_vector(width downto 0);
			flag				: out	std_logic
		);
	end component;
	
	-- function to generate random test-numbers
	function random(seed, size : in positive) return std_logic_vector is
		variable work	: std_logic_vector(size downto 0)
							:= (size => '1', others => '0');
		variable temp	: std_logic := '0';
	begin
		for n in 0 to seed loop
			temp						:= work(size) xor work(size-1);
			work(size downto 1)	:= work(size-1 downto 0);
			work(0)					:= temp;
		end loop;
		return work;
	end random;
	
	-- the asisstant signals
	signal	data_0_sig,
				data_1_sig,
				result_sig	: std_logic_vector(word_length downto 0);
	signal	opcode_sig	: std_logic_vector(1 downto 0);
	signal	flag_sig		: std_logic;
	
	constant clock_period	:	time	:=	4 ps;
	signal clk	:	std_logic;
	
begin

	-- ALU instantiation
	test_ALU : ALU	generic map(word_length)
						port map(
							data_0	=> data_0_sig,
							data_1	=> data_1_sig,
							result	=> result_sig,
							opcode	=> opcode_sig,
							flag		=> flag_sig
						);
						
	-- process to stimulate the test unit
	stim_proc : process
		variable help	: std_logic_vector(2 downto 0);
	begin
	
		for i in 1 to 2**(word_length+1)-1 loop
		
			data_0_sig	<= random(i, word_length);
			data_1_sig	<= random(i+1, word_length); 
			help			:= random(i, 2);
			opcode_sig	<= help(2 downto 1);
			
			wait for 1 ns;
			
		end loop;
		
	end process;
	
	clock_proc: process
	begin
		clk <= '1';
		wait for clock_period/2;
		clk <= '0';
		wait for clock_period/2;
	end process;
	
end ALU_test_behav;
