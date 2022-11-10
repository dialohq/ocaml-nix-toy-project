{ pkgs, lib, nix-filter, fetchFromGitHub, openssl, pkg-config }:

with pkgs.ocamlPackages;

rec {
  ocaml-protoc-plugin = buildDunePackage rec {
    pname = "ocaml-protoc-plugin";
    version = "0.0.1-dev";

    INCLUDE_GOOGLE_PROTOBUF = "${pkgs.protobuf}/include";

    src = fetchFromGitHub {
      owner = "dialohq";
      repo = "ocaml-protoc-plugin";
      rev = "88a099c4e8ff36fddc77c32dfe83a4bbdce64989";
      sha256 = "sha256-6QNxbiQ1gAe13m7bc/sp8FMic5dlYy1siZctJcuzOgA=";
    };

    propagatedBuildInputs = [
      pkgs.protobuf
      pkgs.pkg-config
    ];

    checkInputs = [
      ppx_expect
      ppx_inline_test
      ppx_deriving
    ];
  };

  ppx_string_interpolation = buildDunePackage rec {
    pname = "ppx_string_interpolation";
    version = "1.0.1";

    src = fetchFromGitHub {
      owner = "bloomberg";
      repo = "ppx_string_interpolation";
      rev = "${version}";
      sha256 = "sha256-h6vP4A9ysadJdYiU8BZPqF0bzJ5k70K546EIqjtwHSA=";
    };

    propagatedBuildInputs = [
      ppxlib
      sedlex
    ];
  };

  ocaml-stork = buildDunePackage {
    pname = "stork";
    version = "0.0.1-dev";

    src = fetchFromGitHub {
      owner = "dialohq";
      repo = "stork";
      rev = "0450ed1e1484fff9c61784c1a0040de201b85b4a";
      sha256 = "sha256-U8HM+ezg9SdL1GW9/a70ik6E6JF6JQF2b6bBMRE1CeA=";
    };

    buildInputs = [
      cmdliner
      logs
      fmt
      atd
      atdgen
      biniou
      logs
      ppx_deriving
      ppx_string_interpolation
      yojson
    ];
  };

  ocaml-nix = buildDunePackage {
    pname = "ocaml-nix";
    version = "0.0.1";

    src = with nix-filter.lib; filter {
      root = ../.;
      include = [
        "proj1"
        "proj2"
        "shared"
        "dune"
        "dune-project"
        "ocaml-nix.opam"
      ];
    };

    buildInputs = [
      openssl
      pkg-config
      atdgen
      atdgen-runtime
      # aws-s3-lwt
      biniou
      bisect_ppx
      cmdliner
      cohttp-lwt-unix
      core
      core_unix
      fmt
      ocaml
      # grpc
      # grpc-lwt
      h2
      h2-lwt-unix
      hex
      logs
      lwt
      memtrace
      findlib
      ocaml-protoc-plugin
      patience_diff
      ppx_compare
      ppx_deriving
      ppx_inline_test
      ppx_let
      ppx_yojson_conv
      re
      ocaml-stork
      tyxml
      uuidm
      yojson
    ];
  };
}
