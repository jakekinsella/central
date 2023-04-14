type status_response = {
  message : string;
} [@@deriving yojson]

type login_response = {
  token : string;
} [@@deriving yojson]

type user_response = {
  user : Model.User.Frontend.t;
} [@@deriving yojson]

