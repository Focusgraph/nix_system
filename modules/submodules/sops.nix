{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/home/nixy/.ssh/private_key" ];
    age.keyFile = "/home/nixy/.config/sops/age/keys.txt";
    secrets."nixy_password" = {};
    secrets."nixy_password".neededForUsers = true;
  };
}
