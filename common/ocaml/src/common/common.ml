module Magic = struct
  module Let = struct
    include Magic.Let
  end

  module Lwt = struct
    include Magic.Lwt
  end

  module List = struct
    include Magic.List
  end

  module Option = struct
    include Magic.Option
  end
end

module Api = struct
  let json = Api.Util.json

  module Central = struct
    module Users = struct
      include Api.Central.Users
    end
  end

  module Error = struct
    module Frontend = struct
      include Api.Error.Frontend
    end

    module Database = struct
      include Api.Error.Database
    end
  end

  let throw_error = Error.Frontend.throw_error
end

module Middleware = struct
  let cors = Middleware.Cors.cors
  module Cors = struct
    let routes = Middleware.Cors.routes
  end

  module Auth = struct
    let require_auth = Middleware.Auth.require_auth
    let user_id = Middleware.Auth.user_id
  end
end
