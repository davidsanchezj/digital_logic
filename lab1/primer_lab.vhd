library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity primer_lab is
    Port ( 
        -- Conexiones del teclado
        Row : buffer STD_LOGIC_VECTOR (3 downto 0);
        Col : in STD_LOGIC_VECTOR (3 downto 0);
        
        -- Convertidor BCD
        BCD : buffer STD_LOGIC_VECTOR (3 downto 0);
        
        -- 7-Segmentos
        Segments : out STD_LOGIC_VECTOR (6 downto 0);
        
        -- Encender el Display
        DisplayOn : out STD_LOGIC
    );
end primer_lab;

architecture Behavioral of primer_lab is
    signal KeyPressed : STD_LOGIC := '0';
    signal ScanRow : STD_LOGIC_VECTOR (3 downto 0) := "1110"; -- Inicializar si una fila se activa
    signal KeyMatrix : STD_LOGIC_VECTOR (15 downto 0);
    
    -- Diseño del teclado
    begin
        KeyMatrix(0) <= not Row(0) and not Col(0); -- '1'
        KeyMatrix(1) <= not Row(0) and not Col(1); -- '2'
        KeyMatrix(2) <= not Row(0) and not Col(2); -- '3'
        KeyMatrix(3) <= '0'; -- Tecla no numérica ('A')

        KeyMatrix(4) <= not Row(1) and not Col(0); -- '4'
        KeyMatrix(5) <= not Row(1) and not Col(1); -- '5'
        KeyMatrix(6) <= not Row(1) and not Col(2); -- '6'
        KeyMatrix(7) <= '0'; -- Tecla no numérica ('B')

        KeyMatrix(8) <= not Row(2) and not Col(0); -- '7'
        KeyMatrix(9) <= not Row(2) and not Col(1); -- '8'
        KeyMatrix(10) <= not Row(2) and not Col(2); -- '9'
        KeyMatrix(11) <= '0'; -- Tecla no numérica ('C')

        KeyMatrix(12) <= '0'; -- Tecla no numérica ('D')
        KeyMatrix(13) <= not Row(3) and not Col(1); -- '0'
        KeyMatrix(14) <= '0'; -- Tecla no numérica ('E')
        KeyMatrix(15) <= '0'; -- Tecla no numérica ('F')
    
        -- Detección de la tecla del teclado
        Key_Scan_Process: process(Col)
        begin
            ScanRow <= "1110"; -- Reiniciar las filas
            for i in 0 to 3 loop
                ScanRow(i) <= '1';
                if (Col = "1110") then
                    KeyPressed <= '1';
                    -- Actualizar el BCD basado en la tecla presionada
                end if;
                ScanRow(i) <= '0';
            end loop;
            if Col = "1111" then
                KeyPressed <= '0';
            else
                KeyPressed <= '1';
            end if;
        end process Key_Scan_Process;

        -- Conversión de BCD a 7-Segmentos
        BCD_to_Segment: process(BCD)
        begin
            case BCD is
                when "0000" =>
                    Segments <= "0000001"; -- Mostrar '0'
                when "0001" =>
                    Segments <= "1001111"; -- Mostrar '1'
                when "0010" =>
                    Segments <= "0010010"; -- Mostrar '2'
                when "0011" =>
                    Segments <= "0000110"; -- Mostrar '3'
                when "0100" =>
                    Segments <= "1001100"; -- Mostrar '4'
                when "0101" =>
                    Segments <= "0100100"; -- Mostrar '5'
                when "0110" =>
                    Segments <= "0100000"; -- Mostrar '6'
                when "0111" =>
                    Segments <= "0001111"; -- Mostrar '7'
                when "1000" =>
                    Segments <= "0000000"; -- Mostrar '8'
                when "1001" =>
                    Segments <= "0000100"; -- Mostrar '9'
                when others =>
                    Segments <= "1111111"; -- Apagar la pantalla para otros valores
            end case;
        end process BCD_to_Segment;

        -- Mantener la pantalla apagada si no se presiona ninguna tecla
        DisplayOn <= not KeyPressed;

    end Behavioral;
