module T = Jansson_c.C.Type
module F = Jansson_c.C.Functions

let version () = F.version_str ()

type t =
  Jansson_c.Function_description.T.Json.t Ctypes_static.structure
  Ctypes_static.ptr

let equal = F.Json.equal
let dump = F.Json.dump
let null = F.Json.null
let is_null = F.Json.is_null
let is_bool = F.Json.is_bool
let bool bool = if bool then F.Json.true' () else F.Json.false' ()

let to_bool v =
  if is_bool v then F.Json.to_bool v else invalid_arg "Expected a boolean value"

let is_number = F.Json.Number.is_number
let int = F.Json.Number.int
let float = F.Json.Number.float

let to_number v =
  if is_number v then F.Json.Number.to_number v
  else invalid_arg "Expected a number value"

let is_string = F.Json.is_string
let string = F.Json.string

let to_string v =
  if is_string v then F.Json.to_string v
  else invalid_arg "Expected a string value"

module Array = struct
  let create = F.Json.Array.create
  let size = F.Json.Array.size
  let is_array = F.Json.Array.is_array

  let append arr v =
    match is_array arr with
    | true ->
        let i = F.Json.Array.append_new arr v in
        if i = 0 then () else failwith "Failed to append value to array"
    | false -> invalid_arg "Expected an array to append value to"

  let get arr v =
    match is_array arr with
    | true -> F.Json.Array.get arr v
    | false -> invalid_arg "Expected an array to append value to"
end

module Obj = struct
  let create = F.Json.Object.create
  let is_obj = F.Json.Object.is_obj

  let set obj k v =
    match is_obj obj with
    | true ->
        let i = F.Json.Object.set_new obj k v in
        if i = 0 then () else failwith "Failed to set key-value pair"
    | false -> invalid_arg "Expected an object to set key-value pair"

  let bindings obj =
    let open F.Json.Object in
    match is_obj obj with
    | true ->
        let iter = Iter.create obj in
        let rec aux acc iter =
          if Ctypes.is_null iter then acc
          else
            aux ((Iter.key iter, Iter.value iter) :: acc) (Iter.next obj iter)
        in
        aux [] iter
    | false -> invalid_arg "Expected an object to set key-value pair"
end
