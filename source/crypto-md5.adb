with Ada.Unchecked_Conversion;
with System;
package body Crypto.MD5 is
	use type Ada.Streams.Stream_Element;
	use type C.signed_int;
	
	function Initial return Context is
	begin
		return Result : aliased Context do
			if MD5_Init (Result'Access) = 0 then
				raise Program_Error;
			end if;
		end return;
	end Initial;
	
	procedure Update (
		Context : in out MD5.Context;
		Data : in Ada.Streams.Stream_Element_Array)
	is
		pragma Suppress (Index_Check);
	begin
		if MD5_Update (
			Context'Unrestricted_Access,
			C.void_const_ptr (Data (Data'First)'Address),
			Data'Length) = 0
		then
			raise Program_Error;
		end if;
	end Update;
	
	procedure Update (
		Context : in out MD5.Context;
		Data : in String)
	is
		pragma Suppress (Index_Check);
	begin
		if MD5_Update (
			Context'Unrestricted_Access,
			C.void_const_ptr (Data (Data'First)'Address),
			Data'Length) = 0
		then
			raise Program_Error;
		end if;
	end Update;
	
	procedure Final (Context : in out MD5.Context; Digest : out Fingerprint) is
		function To_Pointer is
			new Ada.Unchecked_Conversion (System.Address, C.unsigned_char_ptr);
	begin
		if MD5_Final (
			To_Pointer (Digest (Digest'First)'Address),
			Context'Unrestricted_Access) = 0
		then
			raise Program_Error;
		end if;
	end Final;
	
	function Value (S : Message_Digest) return Fingerprint is
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
		Digest : Fingerprint;
		Val : Ada.Streams.Stream_Element;
		Hi, Lo : Character;
	begin
		for I in Digest'Range loop
			Hi := S (2 * Integer (I) + 1);
			Lo := S (2 * Integer (I) + 2);
			Val := Digit (Hi) * 16 + Digit (Lo);
			Digest (I) := Val;
		end loop;
		return Digest;
	end Value;
	
	function Image (Digest : in Fingerprint) return Message_Digest is
		Hex_Tab : constant array (0 .. 15) of Character := "0123456789abcdef";
		Result : Message_Digest;
	begin
		for I in Digest'Range loop
			Result (2 * Integer (I) + 1) := Hex_Tab (Natural (Digest (I) / 16));
			Result (2 * Integer (I) + 2) := Hex_Tab (Natural (Digest (I) mod 16));
		end loop;
		return Result;
	end Image;
	
end Crypto.MD5;
