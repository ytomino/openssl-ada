with Ada.IO_Exceptions;
with Ada.Streams;
private with C.openssl.sha;
package Crypto.SHA256 is
	pragma Preelaborate;
	
	subtype Fingerprint is Ada.Streams.Stream_Element_Array (0 .. 31);
	subtype Message_Digest is String (1 .. 64);
	
	type Context (<>) is private;
	
	function Initial return Context;
	
	procedure Update (
		Context : in out SHA256.Context;
		Data : in Ada.Streams.Stream_Element_Array);
	procedure Update (Context : in out SHA256.Context; Data : in String);
	
	procedure Final (Context : in out SHA256.Context; Digest : out Fingerprint);
	
	function Value (S : Message_Digest) return Fingerprint;
	function Image (Digest : Fingerprint) return Message_Digest;
	
	-- exceptions
	
	Use_Error : exception
		renames Ada.IO_Exceptions.Use_Error;
	
private
	
	type Context is record
		SHA : aliased C.openssl.sha.SHA256_CTX;
	end record;
	pragma Suppress_Initialization (Context);
	
	pragma Compile_Time_Error (
		Fingerprint'Length /= C.openssl.sha.SHA256_DIGEST_LENGTH,
		"Fingerprint'Length is mismatch.");
	
end Crypto.SHA256;
