let
  vega = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOmsJ9zTaYRvCl51AC8VE5eNGdCEre7a/g5PS5ZdmVW nixy@vega";
in
{
  "factorio_token.age".publicKeys = [ vega ];
}
