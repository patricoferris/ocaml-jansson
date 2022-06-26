let jansson =
  Alcotest.testable
    (fun ppf v -> Fmt.pf ppf "%s" (Jansson.dump v))
    Jansson.equal

module Ezjsonm_tests = struct
  let ezjsonm =
    Alcotest.testable
      (fun ppf v -> Fmt.pf ppf "%s" (Ezjsonm.value_to_string v))
      Stdlib.( = )

  let test_object () =
    let expect = `O [ ("name", `String "Alice"); ("age", `Float 42.) ] in
    let jansson = Ezjsonm_conv.of_ezjsonm expect in
    let test = Ezjsonm_conv.to_ezjsonm jansson in
    Alcotest.check ezjsonm "same object" expect test

  let test_array () =
    let expect = `A [ `String "Alice"; `Float 42.; `Bool true; `Null ] in
    let jansson = Ezjsonm_conv.of_ezjsonm expect in
    let test = Ezjsonm_conv.to_ezjsonm jansson in
    Alcotest.check ezjsonm "same array" expect test

  let test_inverse () =
    let expect =
      let arr = Jansson.Array.create () in
      List.iter
        (fun f -> Jansson.Array.append arr (Jansson.float f))
        [ 1.; 2.; 3.; 4. ];
      arr
    in
    let ezjsonm = Ezjsonm_conv.to_ezjsonm expect in
    let test = Ezjsonm_conv.of_ezjsonm ezjsonm in
    Alcotest.check jansson "same jansson" expect test

  let tests =
    [
      ("test-object", `Quick, test_object);
      ("test-array", `Quick, test_array);
      ("test-jansson", `Quick, test_inverse);
    ]
end

let () = Alcotest.run "jansson" [ ("ezjsonm", Ezjsonm_tests.tests) ]
