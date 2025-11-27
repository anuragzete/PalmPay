{
  description = "PalmPay dev environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system} = {

      default = pkgs.mkShell {
        packages = with pkgs; [ git ];
        shellHook = ''
          echo "Default shell"
          git --version
        '';
      };

      backend = pkgs.mkShell {
        packages = with pkgs; [
          (python311.withPackages (ps: with ps; [
            fastapi
            uvicorn
            numpy
            opencv4
            pip
          ]))

          # native libs (opencv / cv2 runtime deps)
          stdenv.cc.cc.lib
          zlib
          libffi
          openssl
          glib

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
        ];

        shellHook = ''
          echo "Backend shell"
          python --version

          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.libGL}/lib:${pkgs.glib}/lib:$LD_LIBRARY_PATH
        '';
      };

      frontend = pkgs.mkShell {
        packages = with pkgs; [ nodejs_22 ];
        shellHook = ''
          echo "Frontend shell"
          node --version
          npm --version
        '';
      };

    };
  };
}