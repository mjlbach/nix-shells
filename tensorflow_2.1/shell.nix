let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = with pkgs.python3.pkgs; [
    pip
    numpy
    setuptools
    cudatoolkit_10_1
    cudnn_cudatoolkit_10_1
  ];
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudatoolkit_10_1}/lib:${pkgs.cudnn_cudatoolkit_10_1}/lib:${pkgs.cudatoolkit_10_1.lib}/lib:$LD_LIBRARY_PATH
  '';
}
