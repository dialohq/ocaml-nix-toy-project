(lang dune 3.4)

(version 0.1)

(implicit_transitive_deps true)

(generate_opam_files true)

(license "MIT")

(authors "dialo.ai tech team")

(maintainers "dialo.ai tech team")

(source
 (github dialohq/ocaml-nix-toy-project))

(name ocaml-nix)

(package
 (name ocaml-nix)
 (synopsis
  "Showcase how to transition a regular Opam/dune OCaml project to Nix")
 (depends
  atdgen
  atdgen-runtime
  aws-s3-lwt
  biniou
  (bisect_ppx :with-test)
  cmdliner
  cohttp-lwt-unix
  conf-libssl
  core
  core_unix
  dune
  fmt
  grpc
  grpc-lwt
  (ocaml
   (= 4.14.0))
  h2
  h2-lwt-unix
  hex
  logs
  lwt
  memtrace
  ocamlfind
  (ocamlformat :dev)
  (ocaml-lsp-server :dev)
  ocaml-protoc-plugin
  patience_diff
  ppx_compare
  ppx_deriving
  ppx_inline_test
  ppx_let
  ppx_yojson_conv
  re
  stork
  tyxml
  uuidm
  yojson))
