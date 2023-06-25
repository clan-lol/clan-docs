{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.hiboss.url = "git+https://git.hiboss.com/hiboss";
  inputs.hiboss.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, hiboss, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      hiboss = import hiboss { inherit system pkgs; };
    in
    {
      nixosConfigurations = {
        default = hiboss.nixosSystem {
          adminMode = "local";
          networkLayer= "yggdrasil";
          applications = {
            syncthing = {
              enable = true;
              sharedFolders = "/shared/docs";
            };
            mumbleClient.server = "mumble.hiboss";
          };
        };
      };
    };
}
