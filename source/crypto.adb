package body Crypto is
	use type Ada.Streams.Stream_Element;
	
	procedure Value (
		Image : String;
		Result : out Ada.Streams.Stream_Element_Array)
	is
		function Digit (C : Character) return Ada.Streams.Stream_Element is
		begin
			if C in '0' .. '9' then
				return Character'Pos (C) - Character'Pos ('0');
			elsif C in 'a' .. 'f' then
				return Character'Pos (C) - Character'Pos ('a') + 10;
			elsif C in 'A' .. 'F' then
				return Character'Pos (C) - Character'Pos ('A') + 10;
			else
				raise Constraint_Error;
			end if;
		end Digit;
	begin
		for I in Result'Range loop
			declare
				Hi : constant Character := Image (2 * Integer (I) + 1);
				Lo : constant Character := Image (2 * Integer (I) + 2);
			begin
				Result (I) := Digit (Hi) * 16 + Digit (Lo);
			end;
		end loop;
	end Value;
	
	procedure Image (
		Value : Ada.Streams.Stream_Element_Array;
		Result : out String)
	is
		Hex_Tab : constant array (0 .. 15) of Character := "0123456789abcdef";
	begin
		for I in Value'Range loop
			declare
				Item : constant Ada.Streams.Stream_Element := Value (I);
			begin
				Result (2 * Integer (I) + 1) := Hex_Tab (Natural (Item / 16));
				Result (2 * Integer (I) + 2) := Hex_Tab (Natural (Item mod 16));
			end;
		end loop;
	end Image;
	
end Crypto;
