private with Ada.Streams;
package Crypto is
	pragma Pure;
	pragma Linker_Options ("-lcrypto");
	
private
	
	procedure Value (
		Image : String;
		Result : out Ada.Streams.Stream_Element_Array);
	procedure Image (
		Value : Ada.Streams.Stream_Element_Array;
		Result : out String);
	
end Crypto;
