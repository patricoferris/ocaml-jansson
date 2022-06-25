type t
(** A JSON value *)

val version : unit -> string
(** The version of the Jansson library. *)

val dump : t -> string
(** [dump t] prints the JSON value as a string. *)

val equal : t -> t -> bool
(** [equal a b] checks if the two JSON values are equal.
    See {{: https://jansson.readthedocs.io/en/latest/apiref.html#equality} the docs}. *)

(** {1 Constructors}
    These functions build new {! t} values from OCaml values. For constructing
    arrays and objects, see {! Array} and {! Object} respectively. *)

val null : unit -> t
(** A null JSON value *)

val bool : bool -> t
(** True and false boolean values *)

val to_bool : t -> bool
(** [to_bool t] converts [t] to an OCaml value.
    @raise Invalid_argument If the [t] is the wrong kind of JSON value. *)

val int : int -> t
(** [int i] is a new integer JSON value. *)

val float : float -> t
(** [float f] is a new floating-point JSON value. *)

val to_number : t -> float
(** [to_number t] converts [t] to an OCaml value. This casts integers to floats.
    @raise Invalid_argument If the [t] is the wrong kind of JSON value. *)

val string : string -> t
(** [string s] is a new string JSON value. This will check that
    [s] is UTF-8. *)

val to_string : t -> string
(** [to_string t] converts [t] to an OCaml value.
    @raise Invalid_argument If the [t] is the wrong kind of JSON value. *)

(** {1 Checks} 
    Functions for checking if a {! t} is of a specifc type. *)

val is_null : t -> bool
(** [is_null t] checks if [t] is a Null JSON value. *)

val is_bool : t -> bool
(** [is_bool t] checks if [t] is a Boolean JSON value. *)

val is_number : t -> bool
(** [is_number t] checks if [t] is an integer or real JSON value. *)

val is_string : t -> bool
(** [is_string t] checks if [t] is a string JSON value. *)

module Array : sig
  val create : unit -> t
  (** [ceate ()] produces a new empty array. *)

  val size : t -> int
  (** [size t] returns the size of array [t]. 
      @raise Invalid_argument If [t] is not array. *)

  val is_array : t -> bool
  (** [is_array t] checks if [t] is an array. *)

  val append : t -> t -> unit
  (** [append t v] appends the value [v] to array [t].
     @raise Invalid_argument If [t] is not array. *)

  val get : t -> int -> t
  (** [get t i] gets the [i]th value in the array [t].
     @raise Invalid_argument If [t] is not array.  *)
end

module Obj : sig
  val create : unit -> t
  (** [ceate ()] produces a new empty object. *)

  val is_obj : t -> bool
  (** [is_obj t] checks if [t] is an object. *)

  val set : t -> string -> t -> unit
  (** [set t k v] appends the key-value [(k, v)] to object [t].
       @raise Invalid_argument If [t] is not object. *)

  val bindings : t -> (string * t) list
  (** [bindings t] gets all of the key-value pairs in [t].
       @raise Invalid_argument If [t] is not object.  *)
end
