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
  module Error = struct
    module Frontend = struct
      include Api.Error.Frontend
    end

    module Database = struct
      include Api.Error.Database
    end
  end
end

module Middleware = struct
  let cors = Middleware.Cors.cors
  module Cors = struct
    let routes = Middleware.Cors.routes
  end
end
