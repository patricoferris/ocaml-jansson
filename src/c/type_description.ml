open Ctypes

module Types (F : TYPE) = struct
  module Json = struct
    type t

    let t : t Ctypes_static.structure typ =
      typedef (structure "json_t") "json_t"
  end
end
