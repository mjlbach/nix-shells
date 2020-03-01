let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = with pkgs.python3.pkgs; [
    pip
    numpy
    setuptools
    cudatoolkit_10_0
    cudnn_cudatoolkit_10_0
  ];
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudatoolkit_10_0}/lib:${pkgs.cudnn_cudatoolkit_10_0}/lib:${pkgs.cudatoolkit_10_0.lib}/lib:$LD_LIBRARY_PATH
  '';
}
