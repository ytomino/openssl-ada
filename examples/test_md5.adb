with Ada.Streams;
with Ada.Text_IO;
with Crypto.MD5; use Crypto.MD5;
procedure Test_MD5 is
	procedure Test_01 is
		use type Ada.Streams.Stream_Element_Array;
		C : Context := Initial;
		D : Fingerprint;
	begin
		Update (C, "a");
		Final (C, D);
		pragma Assert (Image (D) = "0cc175b9c0f1b6a831c399e269772661");
		pragma Assert (D = Value (Image (D)));
	end Test_01;
	pragma Debug (Test_01);
	pragma Debug (Ada.Text_IO.Put_Line ("ok."));
begin
	null;
end Test_MD5;
