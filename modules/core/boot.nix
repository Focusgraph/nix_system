{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    limine.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Workaround for cryptoModules until the fix comes to 25.11
  boot.initrd.luks.cryptoModules = [
    "aes"
    # "aes_generic"
    "blowfish"
    "twofish"
    "serpent"
    "cbc"
    "xts"
    "lrw"
    "sha1"
    "sha256"
    "sha512"
    "af_alg"
    "algif_skcipher"
    "cryptd"
    "input_leds"
  ];
}
