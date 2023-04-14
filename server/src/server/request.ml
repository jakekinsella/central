type login_request = {
  email : string;
  password : string;
} [@@deriving yojson]

type validate_request = {
  token : string;
} [@@deriving yojson]
