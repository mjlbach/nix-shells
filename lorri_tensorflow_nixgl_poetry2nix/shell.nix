with import <nixpkgs> {};
let
  src = fetchFromGitHub {
    owner = "nix-community";
    repo = "poetry2nix";
    rev = "98df940936e09164fdf30f3348fc071403667074";
    sha256 = "163d72djp5z6459v964ij2qam4p2zw6xfjfh3b94qz8xyi2c3w15";
  };
in
  with import "${src.out}/overlay.nix" pkgs pkgs;
  let
    pythonEnv = poetry2nix.mkPoetryEnv {
      projectDir = ./.;
      preferWheels = true;
    };
  in
  mkShell {
    name = "tf-dev-environment";

    nativeBuildInputs = [
      pythonEnv
    ];

    shellHook = ''
      export LD_LIBRARY_PATH=${pkgs.libGL}/lib:${pkgs.libGLU}/lib:${pkgs.freeglut}/lib:${pkgs.xorg.libX11}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudatoolkit_10_1}/lib:${pkgs.cudnn_cudatoolkit_10_1}/lib:${pkgs.cudatoolkit_10_1.lib}/lib:$LD_LIBRARY_PATH
      export LD_LIBRARY_PATH=$(nixGLNvidia printenv LD_LIBRARY_PATH):$LD_LIBRARY_PATH
    '';
  }
