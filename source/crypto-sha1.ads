with Ada.Streams;
private with C.openssl.sha;
package Crypto.SHA1 is
	pragma Preelaborate;
	
	subtype Fingerprint is Ada.Streams.Stream_Element_Array (0 .. 19);
	subtype Message_Digest is String (1 .. 40);
	
	type Context (<>) is private;
	
	function Initial return Context;
	
	procedure Update (
		Context : in out SHA1.Context;
		Data : in Ada.Streams.Stream_Element_Array);
	procedure Update (
		Context : in out SHA1.Context;
		Data : in String);
	
	procedure Final (Context : in out SHA1.Context; Digest : out Fingerprint);
	
	function Value (S : Message_Digest) return Fingerprint;
	function Image (Digest : Fingerprint) return Message_Digest;
	
private
	
	type Context is new C.openssl.sha.SHA_CTX;
	
	pragma Compile_Time_Error (
		Fingerprint'Length /= C.openssl.sha.SHA_DIGEST_LENGTH,
		"Fingerprint'Length is mismatch.");
	
end Crypto.SHA1;
