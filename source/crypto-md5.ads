with Ada.Streams;
private with C.openssl.md5;
package Crypto.MD5 is
	pragma Preelaborate;
	
	subtype Fingerprint is Ada.Streams.Stream_Element_Array (0 .. 15);
	subtype Message_Digest is String (1 .. 32);
	
	type Context (<>) is private;
	
	function Initial return Context;
	
	procedure Update (
		Context : in out MD5.Context;
		Data : in Ada.Streams.Stream_Element_Array);
	procedure Update (Context : in out MD5.Context; Data : in String);
	
	procedure Final (Context : in out MD5.Context; Digest : out Fingerprint);
	
	function Value (S : Message_Digest) return Fingerprint;
	function Image (Digest : Fingerprint) return Message_Digest;
	
private
	
	type Context is record
		MD5 : aliased C.openssl.md5.MD5_CTX;
	end record;
	pragma Suppress_Initialization (Context);
	
	pragma Compile_Time_Error (
		Fingerprint'Length /= C.openssl.md5.MD5_DIGEST_LENGTH,
		"Fingerprint'Length is mismatch.");
	
end Crypto.MD5;
