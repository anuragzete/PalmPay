{
  description = "NIX environment for Palm Pay - Backend";

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
          python311
          python311Packages.pip
          stdenv.cc.cc.lib 
          zlib
          libffi
          openssl
          libGL
          libGLU
          xorg.libX11
          xorg.libXext
          xorg.libSM
          xorg.libICE
          xorg.libxcb
          xorg.libXrender
          xorg.libXrandr
          xorg.libXi
          glib
        ];
        shellHook = ''
          echo "Backend shell loaded"
          	echo "Git: $(git --version)"
          echo "Python: $(python --version)"
          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.libGL}/lib:${pkgs.glib}/lib:$LD_LIBRARY_PATH
        '';
      };
    };
  };
}
