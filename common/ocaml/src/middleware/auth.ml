open Api
open Api.Util

type status_response = {
  message : string;
} [@@deriving yojson]

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
        let token = Str.matched_group 1 auth in
        Some token
      with _ -> None)
    | None -> None

let try_cookie request =
  match Dream.cookie request "token" with
    | Some token -> Some token
    | None -> None

let validate token =
  (match%lwt Central.Users.validate token with
    | Ok user -> Lwt.return_ok (Some user.id)
    | Error _ -> Lwt.return_ok None)

let require_auth (inner_handler : Dream.handler) (request : Dream.request) : Dream.response Lwt.t =
  let maybe_token = try_header request |> Magic.Option.or_else (fun _ -> try_cookie request) in
  let%lwt id = maybe_token |> Option.map (fun token -> validate token) |> Option.value ~default: (Lwt.return_ok None) in
  match id with
    | Ok (Some id) ->
      Dream.set_field request user_id id;
      inner_handler request
    | _ ->
      access_denied ()