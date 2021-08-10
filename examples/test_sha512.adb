with Ada.Streams;
with Ada.Text_IO;
with Crypto.SHA512; use Crypto.SHA512;
procedure Test_SHA512 is
	procedure Test_01 is
		use type Ada.Streams.Stream_Element_Array;
		C : Context := Initial;
		D : Fingerprint;
	begin
		Update (C, "a");
		Final (C, D);
		pragma Assert (
			Image (D) =
				"1f40fc92da241694750979ee6cf582f2d5d7d28e18335de05abc54d0560e0f5302860c652bf08"
					& "d560252aa5e74210546f369fbbbce8c12cfc7957b2652fe9a75");
		pragma Assert (D = Value (Image (D)));
	end Test_01;
	pragma Debug (Test_01);
begin
	-- finish
	Ada.Text_IO.Put_Line (Ada.Text_IO.Standard_Error.all, "ok");
end Test_SHA512;
