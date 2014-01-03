--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package cpu_types is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--
	
	
	type t_MemRegister_15_32 is array (0 to 14) of STD_LOGIC_VECTOR(31 downto 0);
	
	-- CPU Registers address
	constant R1_addr  : integer := 0; 	-- PC
	constant R2_addr  : integer := 1; 	-- IR
	constant R3_addr  : integer := 2; 	-- SP
	constant R4_addr  : integer := 3; 	-- PSR
	constant R5_addr  : integer := 4; 	-- GPR
	constant R6_addr  : integer := 5; 	-- GPR
	constant R7_addr  : integer := 6; 	-- GPR
	constant R8_addr  : integer := 7; 	-- GPR
	constant R9_addr  : integer := 8; 	-- GPR
	constant R10_addr : integer := 9; 	-- GPR
	constant R11_addr : integer := 10;  -- GPR
	constant R12_addr : integer := 11;  -- GPR
	constant R13_addr : integer := 12;  -- GPR
	constant R14_addr : integer := 13;  -- GPR
	constant R15_addr : integer := 14;  -- GPR

end cpu_types;

package body cpu_types is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end cpu_types;
