{
  description = "NIX environment for Palm Pay - Frontend App";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in {
    devShells.${system} = {

      # Default shell
      default = pkgs.mkShell {
        packages = with pkgs; [
          git
          nodejs_22
        ];
        shellHook = ''
          echo "Default shell loaded"
          echo "Node: $(node --version)"
          echo "npm: $(npm --version)"
          echo "Git: $(git --version)"
        '';
      };
    };
  };
}
