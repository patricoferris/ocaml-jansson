open Ctypes
module T = Types_generated

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  let version_str =
    foreign "jansson_version_str" (void @-> returning string)

  module Json = struct
    let equal = foreign "json_equal" (ptr T.Json.t @-> ptr T.Json.t @-> returning bool)
    let dump = foreign "json_dumps" (ptr T.Json.t @-> int @-> returning string)
    let null = foreign "json_null" (void @-> returning @@ ptr T.Json.t)
    let is_null = foreign "json_is_null" (ptr T.Json.t @-> returning bool)
    let is_bool = foreign "json_is_boolean" (ptr T.Json.t @-> returning bool)
    let true' = foreign "json_true" (void @-> returning @@ ptr T.Json.t)
    let false' = foreign "json_false" (void @-> returning @@ ptr T.Json.t)

    let to_bool = foreign "json_boolean_value" (ptr T.Json.t @-> returning bool)

    let string = foreign "json_string" (string @-> returning @@ ptr T.Json.t)
    let is_string = foreign "json_is_string" (ptr T.Json.t @-> returning bool)

    let to_string = foreign "json_string_value" (ptr T.Json.t @-> returning Ctypes.string)

    module Number = struct
      let is_number = foreign "json_is_number" (ptr T.Json.t @-> returning bool)
      let int = foreign "json_integer" (llong @-> returning @@ ptr T.Json.t)
      let to_int = foreign "json_integer_value" (ptr T.Json.t @-> returning llong)

      let float = foreign "json_real" (double @-> returning @@ ptr T.Json.t)

      let to_number = foreign "json_number_value" (ptr T.Json.t @-> returning double)
    end

    module Array = struct
      let is_array = foreign "json_is_array" (ptr T.Json.t @-> returning bool)
      let create = foreign "json_array" (void @-> returning @@ ptr T.Json.t)
      let append_new = foreign "json_array_append_new" (ptr T.Json.t @-> ptr T.Json.t @-> returning int)
      let size = foreign "json_array_size" (ptr T.Json.t @-> returning int)
      let get = foreign "json_array_get" (ptr T.Json.t @-> int @-> returning @@ ptr T.Json.t)
    end

    module Object = struct
      let is_obj = foreign "json_is_object" (ptr T.Json.t @-> returning bool)
      let create = foreign "json_object" (void @-> returning @@ ptr T.Json.t)
      let set_new = foreign "json_object_set" (ptr T.Json.t @-> Ctypes.string @-> ptr T.Json.t @-> returning int)

      module Iter = struct

        let create = foreign "json_object_iter" (ptr T.Json.t @-> returning (ptr void))
        let key = foreign "json_object_iter_key" (ptr void @-> returning Ctypes.string)
        let value = foreign "json_object_iter_value" (ptr void @-> returning (ptr T.Json.t))
        let next = foreign "json_object_iter_next" (ptr T.Json.t @-> ptr void @-> returning (ptr void))
      end
    end
  end
end