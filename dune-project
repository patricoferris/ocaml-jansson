(lang dune 3.0)
(using ctypes 0.1)
(name jansson)
(generate_opam_files true)
(source
 (github patricoferris/ocaml-jansson))
(authors "Patrick Ferris")
(maintainers "Patrick Ferris")
(license MIT)
(documentation https://ocaml.org/p/jansson)
(package
 (name jansson)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   ctypes
   conf-autoconf
   (alcotest :with-test)
   (ezjsonm :with-test)))