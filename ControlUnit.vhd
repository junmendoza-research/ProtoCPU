----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:06:01 11/17/2013 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code. 
--library UNISIM;
--use UNISIM.VComponents.all;

use cpu_types.ALL;

entity ControlUnit is
    Port ( 
		clock : in STD_LOGIC;
		reset : in STD_LOGIC;
		result : out STD_LOGIC
			);
			
end ControlUnit;


-------------------------------------
-- component ControlUnit()
--		MemoryInit()
--		LoadInstructions()
--		SetFirstPC()
--		Fetch(in pc, out instr)
--		Decode(in instr, out pc)
--		GetNextPC(out pc)
-- end component
-------------------------------------
	
architecture Behavioral of ControlUnit is

	------------------------------------
	-- Component definitions 
	------------------------------------
	component Fetch is 
		Port( clock : in STD_LOGIC; 
				pc : in STD_LOGIC_VECTOR(31 downto 0);
				programdata : in t_MemProgramData_32_32;
				instr : out STD_LOGIC_VECTOR(31 downto 0)
			 );
	end component Fetch;
	
	component Decode is  
		Port( clock : in STD_LOGIC;
				instruction : in STD_LOGIC_VECTOR(31 downto 0); 
				command : out STD_LOGIC_VECTOR(31 downto 0)
			 );
	end component Decode;
	
	component Execute is  
		Port( clock : in  STD_LOGIC;
				instruction : in STD_LOGIC_VECTOR(31 downto 0); 
				command : in STD_LOGIC_VECTOR(31 downto 0); 
				endprogram : out STD_LOGIC;
				nextpc : out STD_LOGIC;
				memregion_register : inout t_MemRegister_15_32
		    );
	end component Execute;
	
	component GetNextPC is 
		Port( clock : in STD_LOGIC;
				nextpc : in STD_LOGIC;	
			   pc : out STD_LOGIC_VECTOR(31 downto 0)
			 );
	end component GetNextPC;
	
	
	------------------------------------
	-- ControlUnit signals
	------------------------------------
	
	signal endexecution : STD_LOGIC;
	signal exec_getpc : STD_LOGIC;
	
	-- Registers
	signal R1  : STD_LOGIC_VECTOR(31 downto 0);
	signal R2  : STD_LOGIC_VECTOR(31 downto 0);
	signal R3  : STD_LOGIC_VECTOR(31 downto 0);
	signal R4  : STD_LOGIC_VECTOR(31 downto 0);
	signal R5  : STD_LOGIC_VECTOR(31 downto 0);
	signal R6  : STD_LOGIC_VECTOR(31 downto 0);
	signal R7  : STD_LOGIC_VECTOR(31 downto 0);
	signal R8  : STD_LOGIC_VECTOR(31 downto 0);
	signal R9  : STD_LOGIC_VECTOR(31 downto 0);
	signal R10 : STD_LOGIC_VECTOR(31 downto 0);
	signal R11 : STD_LOGIC_VECTOR(31 downto 0);
	signal R12 : STD_LOGIC_VECTOR(31 downto 0);
	signal R13 : STD_LOGIC_VECTOR(31 downto 0);
	signal R14 : STD_LOGIC_VECTOR(31 downto 0);
	signal R15 : STD_LOGIC_VECTOR(31 downto 0);
	
	-- Command signals
	signal execute_add  : STD_LOGIC;
	signal execute_sub  : STD_LOGIC;
	signal execute_mul  : STD_LOGIC;
	signal execute_div  : STD_LOGIC;
	signal execute_and  : STD_LOGIC;
	signal execute_nand : STD_LOGIC;
	signal execute_or   : STD_LOGIC;
	signal execute_nor  : STD_LOGIC;
	signal execute_xor  : STD_LOGIC;
	signal execute_xnor : STD_LOGIC;
	signal execute_not  : STD_LOGIC;
	signal execute_shl  : STD_LOGIC;
	signal execute_shr  : STD_LOGIC;
		
	signal execute_mov  : STD_LOGIC;
	signal execute_ldr  : STD_LOGIC;
	signal execute_str  : STD_LOGIC;
	signal execute_push : STD_LOGIC;
	signal execute_pop  : STD_LOGIC;
		
	signal execute_jmp  : STD_LOGIC;
		
	signal execute_int  : STD_LOGIC;
	
	------------------------------------
	-- Initialize program region (Instruction Stream)
	-- 32 * 16-bit
	------------------------------------
	signal memregion_program : t_MemProgramData_32_32 := 
	(
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000"	
	);
	 
begin
	
	-- Set start PC	
	--R1 <= X"00000000";
	
	
	FetchInstruction : Fetch port map(clock, R1, memregion_program, R2);

	DecodeInstruction : Decode port map 
	(
		clock,
		R2,
		R5
	);
	
	ExecuteCommand: Execute port map
	(
		clock,
		R2,
		R5,
		
		endexecution, 
		exec_getpc,
		
		memregion_register(R1_addr) => R1, 
		memregion_register(R2_addr) => R2, 
		memregion_register(R3_addr) => R3, 
		memregion_register(R4_addr) => R4, 
		memregion_register(R5_addr) => R5, 
		memregion_register(R6_addr) => R6, 
		memregion_register(R7_addr) => R7, 
		memregion_register(R8_addr) => R8, 
		memregion_register(R9_addr) => R9, 
		memregion_register(R10_addr) => R10, 
		memregion_register(R11_addr) => R11, 
		memregion_register(R12_addr) => R12, 
		memregion_register(R13_addr) => R13, 
		memregion_register(R14_addr) => R14, 
		memregion_register(R15_addr) => R15
	);
	
	GetPC : GetNextPC port map(clock, exec_getpc, R1);	
	
end architecture Behavioral;

