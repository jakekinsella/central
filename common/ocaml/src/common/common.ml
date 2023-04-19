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
