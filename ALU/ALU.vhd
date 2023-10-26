library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port (
        A, B: in STD_LOGIC_VECTOR(3 downto 0); -- 4-bit inputs
        ALUOp: in STD_LOGIC_VECTOR(2 downto 0); -- Operation selection
        Result: out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit result
        Zero: out STD_LOGIC_VECTOR(2 downto 0); -- Output indicating the comparison result (G, E, L)
        -- Add LED output ports for A, B, ALUOP
        LED_A, LED_B: out STD_LOGIC_VECTOR(3 downto 0);
		  LED_ALUOP: out STD_LOGIC_VECTOR(2 downto 0)
    );
end ALU;


architecture Behavioral of ALU is
begin
    process (A, B, ALUOp)
        variable temp: STD_LOGIC_VECTOR(3 downto 0); -- 4-bit result
    begin
        -- Initialize temp to '0'
        temp := (others => '0');
        
        -- Assign the values of A and B to the LED_A and LED_B outputs
        LED_A <= A;
        LED_B <= B;
		  LED_ALUOP <= ALUOP;

        -- Arithmetic and Logic operations
        case ALUOp is
            when "000" =>
                temp := A + B; -- Addition
					 Zero <= "000";
            when "001" =>
                temp := A - B; -- Subtraction
					 Zero <= "000";
            when "010" =>
                temp := A AND B; -- Bitwise AND
					 Zero <= "000";
            when "011" =>
                temp := A OR B; -- Bitwise OR
					 Zero <= "000";
            when "100" =>
                temp := A XOR B; -- Bitwise XOR
					 Zero <= "000";
				when "101" =>
                temp := A NAND B; -- Bitwise NAND
					 Zero <= "000";
				when "110" =>
                temp := A NOR B; -- Bitwise NOR
					 Zero <= "000";
            when "111" =>
                -- Comparison for 4-bit inputs (A > B, A = B, A < B)
                if A > B then
                    Zero <= "001"; -- A is greater than B
                elsif A = B then
                    Zero <= "010"; -- A is equal to B
                else
                    Zero <= "100"; -- A is less than B
                end if;
            when others =>
                -- Handle unsupported ALUOp values
                temp := (others => '0');
        end case;
        
        Result <= temp; -- Output the 4-bit result
    end process;

end Behavioral;
