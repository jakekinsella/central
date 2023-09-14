open Common.Api
open Model

open Request
open Response
open Util

let routes = [
  Dream.scope "/api/users" [Common.Middleware.cors] [
    Dream.post "/login" (fun request ->
      let%lwt body = Dream.body request in

      let req = body |> Yojson.Safe.from_string |> login_request_of_yojson in
      match req with
        | Ok { email; password = password } ->
          Dream.log "[/users/login] email: %s" email;
          (match%lwt Dream.sql request (Database.Users.by_email email) with
            | Ok user ->
              Dream.log "[/users/login] email: %s - lookup success" email;
              if Model.User.Internal.verify password user
                then
                  let token = Model.User.Internal.sign jwk user in
                    json { token = token } login_response_to_yojson
                else throw_error Error.Frontend.NotFound
            | Error e ->
              let message = Error.Database.to_string e in
                Dream.log "[/users/login] email: %s - lookup failed with %s" email message;
              throw_error Error.Frontend.NotFound)
        | _ ->
          throw_error Error.Frontend.BadRequest
    );

    Dream.post "/validate" (fun request ->
      let%lwt body = Dream.body request in

      let req = body |> Yojson.Safe.from_string |> validate_request_of_yojson in
      match req with
        | Ok { token } ->
          Dream.log "[/users/validate] token: %s" token;
          (match Model.User.Internal.validate Util.jwk token with
            | Ok id ->
              (match%lwt Dream.sql request (Database.Users.by_id id) with
                | Ok user ->
                  Dream.log "[/users/validate] token: %s - lookup success" token;
                  json { user = User.Frontend.to_frontend user } user_response_to_yojson
                | Error e ->
                  let message = Error.Database.to_string e in
                    Dream.log "[/users/validate] lookup failed with %s" message;
                  throw_error Error.Frontend.NotFound)
            | Error _ ->
              Dream.log "[/users/validate] invalid token";
              throw_error Error.Frontend.Forbidden)
        | _ ->
          throw_error Error.Frontend.BadRequest
    );
  ]
]