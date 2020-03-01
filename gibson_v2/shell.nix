let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = (with pkgs.python3.pkgs; [
    pip
    numpy
    setuptools

  ]) ++ (with pkgs ; [
    glxinfo
    cmake
    cudatoolkit_10_0
    cudnn_cudatoolkit_10_0
    xorg.libX11
  ]);
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.libGL}/lib:${pkgs.libGLU}/lib:${pkgs.freeglut}/lib:${pkgs.xorg.libX11}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudatoolkit_10_0}/lib:${pkgs.cudnn_cudatoolkit_10_0}/lib:${pkgs.cudatoolkit_10_0.lib}/lib:$LD_LIBRARY_PATH
    alias pip="PIP_PREFIX='$(pwd)/_build/pip_packages' TMPDIR='$HOME' \pip"
    export PYTHONPATH="$(pwd)/_build/pip_packages/lib/python3.7/site-packages:$PYTHONPATH"
    export PATH="$(pwd)/_build/pip_packages/bin:$PATH"
    unset SOURCE_DATE_EPOCH
    export CXXFLAGS=-isystem\ ${pkgs.cudatoolkit_10_0}/extras/CUPTI/include
  '';
}
