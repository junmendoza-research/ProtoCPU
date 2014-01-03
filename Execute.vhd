----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:30:09 01/02/2014 
-- Design Name: 
-- Module Name:    Execute - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use cpu_types.ALL;

entity Execute is
    Port(
			clock : in  STD_LOGIC;
			instruction : in STD_LOGIC_VECTOR(31 downto 0); 
			
			exec_add  : in STD_LOGIC;
			exec_sub  : in STD_LOGIC;
			exec_mul  : in STD_LOGIC;
			exec_div  : in STD_LOGIC;
			exec_and  : in STD_LOGIC;
			exec_nand : in STD_LOGIC;
			exec_or   : in STD_LOGIC;
			exec_nor  : in STD_LOGIC;
			exec_xor  : in STD_LOGIC;
			exec_xnor : in STD_LOGIC;
			exec_not  : in STD_LOGIC;
			exec_shl  : in STD_LOGIC;
			exec_shr  : in STD_LOGIC;
			
			exec_mov  : in STD_LOGIC;
			exec_ldr  : in STD_LOGIC;
			exec_str  : in STD_LOGIC;
			exec_push : in STD_LOGIC;
			exec_pop  : in STD_LOGIC;
			
			exec_jmp : in STD_LOGIC;
			
			exec_int : in STD_LOGIC;
			
			endprogram : out STD_LOGIC;
			nextpc : out STD_LOGIC;
			memregion_register : inout t_MemRegister_15_32
		   );
end Execute;

architecture Behavioral of Execute is

begin


end Behavioral;

