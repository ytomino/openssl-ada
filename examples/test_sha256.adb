with Ada.Streams;
with Ada.Text_IO;
with Crypto.SHA256; use Crypto.SHA256;
procedure Test_SHA256 is
	procedure Test_01 is
		use type Ada.Streams.Stream_Element_Array;
		C : Context := Initial;
		D : Fingerprint;
	begin
		Update (C, "a");
		Final (C, D);
		pragma Assert (
			Image (D) =
				"ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
		pragma Assert (D = Value (Image (D)));
	end Test_01;
	pragma Debug (Test_01);
begin
	-- finish
	Ada.Text_IO.Put_Line (Ada.Text_IO.Standard_Error.all, "ok");
end Test_SHA256;
