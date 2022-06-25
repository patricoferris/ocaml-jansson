let rec to_ezjsonm : Jansson.t -> Ezjsonm.value = function
  | t when Jansson.is_null t -> `Null
  | t when Jansson.is_bool t -> `Bool (Jansson.to_bool t)
  | t when Jansson.is_string t -> `String (Jansson.to_string t)
  | t when Jansson.is_number t -> `Float (Jansson.to_number t)
  | t when Jansson.Array.is_array t ->
      let size = Jansson.Array.size t in
      `A (List.init size (fun i -> Jansson.Array.get t i |> to_ezjsonm))
  | t when Jansson.Obj.is_obj t ->
      let bindings = Jansson.Obj.bindings t |> List.rev in
      `O (List.map (fun (k, v) -> (k, to_ezjsonm v)) bindings)
  | _ -> assert false

let rec of_ezjsonm : Ezjsonm.value -> Jansson.t = function
  | `Bool b -> Jansson.bool b
  | `Null -> Jansson.null ()
  | `Float f -> Jansson.float f
  | `String s -> Jansson.string s
  | `A lst ->
      let arr = Jansson.Array.create () in
      List.iter (Jansson.Array.append arr) (List.map of_ezjsonm lst);
      arr
  | `O assoc ->
      let obj = Jansson.Obj.create () in
      List.iter (fun (k, v) -> Jansson.Obj.set obj k (of_ezjsonm v)) assoc;
      obj
