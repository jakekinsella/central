let cors (inner_handler : Dream.handler) (request : Dream.request) : Dream.response Lwt.t =
  let new_headers = [ ("Access-Control-Allow-Methods", "OPTIONS, GET, HEAD, POST, DELETE"); ("Access-Control-Allow-Origin", "*"); ("Access-Control-Allow-Headers", "*"); ] in
  let%lwt response = inner_handler request in
  let _ = new_headers |> List.map (fun (key, value) -> Dream.add_header response key value) in
    Lwt.return response

let routes = [
  Dream.scope "" [cors] [
    Dream.options "**" (fun _ ->
      Dream.respond ~headers: [("Access-Control-Allow-Methods", "OPTIONS, GET, HEAD, POST, DELETE")] ""
    )
  ]
]
