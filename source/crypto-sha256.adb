with Ada.Unchecked_Conversion;
with System;
package body Crypto.SHA256 is
	use type C.signed_int;
	
	function Initial return Context is
	begin
		return Result : Context do
			if C.openssl.sha.SHA256_Init (Result.SHA'Access) = 0 then
				raise Use_Error;
			end if;
		end return;
	end Initial;
	
	procedure Update (
		Context : in out SHA256.Context;
		Data : in Ada.Streams.Stream_Element_Array)
	is
		pragma Suppress (Index_Check);
	begin
		if C.openssl.sha.SHA256_Update (
			Context.SHA'Access,
			C.void_const_ptr (Data (Data'First)'Address),
			Data'Length) = 0
		then
			raise Use_Error;
		end if;
	end Update;
	
	procedure Update (Context : in out SHA256.Context; Data : in String) is
		pragma Suppress (Index_Check);
	begin
		if C.openssl.sha.SHA256_Update (
			Context.SHA'Access,
			C.void_const_ptr (Data (Data'First)'Address),
			Data'Length) = 0
		then
			raise Use_Error;
		end if;
	end Update;
	
	procedure Final (Context : in out SHA256.Context; Digest : out Fingerprint) is
		function To_Pointer is
			new Ada.Unchecked_Conversion (System.Address, C.unsigned_char_ptr);
	begin
		if C.openssl.sha.SHA256_Final (
			To_Pointer (Digest (Digest'First)'Address),
			Context.SHA'Access) = 0
		then
			raise Use_Error;
		end if;
	end Final;
	
	function Value (S : Message_Digest) return Fingerprint is
	begin
		return Result : Fingerprint do
			Value (S, Result);
		end return;
	end Value;
	
	function Image (Digest : in Fingerprint) return Message_Digest is
	begin
		return Result : Message_Digest do
			Image (Digest, Result);
		end return;
	end Image;
	
end Crypto.SHA256;
