open Lwt
open Cohttp_lwt_unix

let host = (Sys.getenv_opt "CENTRAL_BASE" |> Option.value ~default: "http://central-server:8080/api")

module Model = struct
  module User = struct
    type t = {
      id : string;
      email : string;
    } [@@deriving yojson]
  end

  module Request = struct
    type validate_request = {
      token : string;
    } [@@deriving yojson]
  end

  module Response = struct
    type user_response = {
      user : User.t;
    } [@@deriving yojson]
  end
end

let post uri body =
  Client.post (Uri.of_string uri) ~body: (`String body) >>= fun (_, body) ->
    body |> Cohttp_lwt.Body.to_string

module Users = struct
  open Model.Request
  open Model.Response

  let validate (token) =
    let uri = (host ^ "/users/validate") in
    let body = { token = token } |> validate_request_to_yojson |> Yojson.Safe.to_string in
    let%lwt response = post uri body in
    response |> Yojson.Safe.from_string |> user_response_of_yojson |> Result.map (fun res -> res.user) |> Lwt_result.lift
end
