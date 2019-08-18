-- Copyright (C) 2019, 0l-l0
-- License: MPL-2.0
-- Authors: 0l-l0
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

--------------------------------------------------------------------
-- This file contains the value of the constant "width" and the type
-- that every other module use.

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package data_type is

	constant width	: positive := 8;
	type data_arr is array(0 to 7) of std_logic_vector(width-1 downto 0);

end data_type;
