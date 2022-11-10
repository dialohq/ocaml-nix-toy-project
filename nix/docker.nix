{ pkgs, ocaml-nix }:

pkgs.dockerTools.buildImage rec {
  name = "ocaml-nix";

  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    paths = [
      pkgs.zsh
      pkgs.coreutils
      pkgs.dockerTools.fakeNss
    ];
    pathsToLink = [ "/bin" ];
  };

  runAsRoot = ''
    mkdir -p ${config.WorkingDir} 
  '';

  config = {
    Entrypoint = [ "${ocaml-nix}/bin/proj1" ];
    architecture = "amd64";
    os = "linux";

    ExposedPorts = {
      "8080/tcp" = { };
    };

    WorkingDir = "/app";


    Env = [
      "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
      "NIX_SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    ];
  };
}
