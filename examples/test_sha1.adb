with Ada.Streams;
with Ada.Text_IO;
with Crypto.SHA1; use Crypto.SHA1;
procedure Test_SHA1 is
	procedure Test_01 is
		use type Ada.Streams.Stream_Element_Array;
		C : Context := Initial;
		D : Fingerprint;
	begin
		Update (C, "a");
		Final (C, D);
		pragma Assert (Image (D) = "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8");
		pragma Assert (D = Value (Image (D)));
	end Test_01;
	pragma Debug (Test_01);
begin
	-- finish
	Ada.Text_IO.Put_Line (Ada.Text_IO.Standard_Error.all, "ok");
end Test_SHA1;
