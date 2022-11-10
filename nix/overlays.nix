final: prev:

{
  ocamlPackages = prev.ocamlPackages.overrideScope' (oself: osuper: {
    atdgen-codec-runtime = osuper.atdgen-codec-runtime.overrideAttrs (_: rec {
      version = "2.9.1";

      src = prev.fetchurl {
        url = "https://github.com/ahrefs/atd/releases/download/${version}/atdts-${version}.tbz";
        sha256 = "sha256-OdwaUR0Ix0Oz8NDm36nIyvIRzF+r/pKgiej1fhcOmuQ=s";
      };
    });

    yojson = oself.buildDunePackage rec {
      pname = "yojson";
      version = "1.7.0";
      src = prev.fetchFromGitHub {
        owner = "ocaml-community";
        repo = "yojson";
        rev = version;
        sha256 = "sha256-VvbBwQ9/SKhVupBL0x8lSDqIhIH2MLfdDXCutxDXzH4=";
      };

      nativeBuildInputs = with oself; [
        ocaml
        dune
        cppo
      ];

      propagatedBuildInputs = with oself; [
        easy-format
        biniou
      ];

      checkInputs = with oself; [
        alcotest
      ];
    };
  });
}
