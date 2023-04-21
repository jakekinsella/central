let json ?(status = `OK) response encoder =
  response |> encoder |> Yojson.Safe.to_string |> Dream.json ~status: status
