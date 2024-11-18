open Common
open Common.Api

open Response

let jwk =
  Jose.Jwk.make_oct (Sys.getenv "SECRET_KEY")

module Middleware = struct
  let user_id =
    Dream.new_field ~name: "user_id" ~show_value: (fun x -> x) ()

  let bearer_token = Str.regexp "Bearer \\(.*\\)"

  let access_denied () =
    json ~status: `Forbidden { message = "Access denied" } status_response_to_yojson

  let try_header request =
    match Dream.header request "authentication" with
      | Some auth ->
        (try
          let _ = Str.string_match bearer_token auth 0 in
            match (Str.matched_group 1 auth |> Model.User.Internal.validate jwk) with
              | Ok id -> Some id
              | Error _ -> None
        with _ -> None)
      | None ->
        None

  let try_cookie request =
    match Dream.cookie request "token" with
      | Some token ->
        (match Model.User.Internal.validate jwk token with
          | Ok id -> Some id
          | Error _ -> None)
      | None ->
        None

  let require_auth (inner_handler : Dream.handler) (request : Dream.request) : Dream.response Lwt.t =
    match try_header request |> Magic.Option.or_else (fun _ -> try_cookie request) with
      | Some id ->
        Dream.set_field request user_id id;
        inner_handler request
      | None ->
        access_denied ()
end
