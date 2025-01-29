interface EndpointDefinition {
  domain: string;
  reader: { root: string, api: string };
  notes: { root: string };
  search: { root: string };
  budgeting: { root: string, api: string };
  blob: { api: string };
  central: { root: string, api: string };
}

const init = () : EndpointDefinition => {
  if (window.location.protocol === "https:" && window.location.host.includes("cluster.local")) {
    return {
      domain: "cluster.local",
      reader: {
        root: "https://reader.cluster.local", 
        api: "https://reader.cluster.local/api"
      },
      notes: {
        root: "https://notes.cluster.local"
      },
      search: {
        root: "https://search.cluster.local"
      },
      budgeting: {
        root: "https://budgeting.cluster.local",
        api: "https://budget.cluster.local"
      },
      blob: {
        api: "https://blob.cluster.local/api"
      },
      central: {
        root: "https://central.cluster.local", 
        api: "https://central.cluster.local/api"
      }
    };
  } else if (window.location.protocol === "https:") {
    return {
      domain: "jakekinsella.com",
      reader: {
        root: "https://reader.jakekinsella.com", 
        api: "https://reader.jakekinsella.com/api"
      },
      notes: {
        root: "https://notes.jakekinsella.com"
      },
      search: {
        root: "https://search.jakekinsella.com"
      },
      budgeting: {
        root: "https://budgeting.jakekinsella.com", 
        api: "https://budgeting.jakekinsella.com"
      },
      blob: {
        api: "https://blob.jakekinsella.com/api"
      },
      central: {
        root: "https://central.jakekinsella.com", 
        api: "https://central.jakekinsella.com/api"
      }
    };
  } else {
    return {
      domain: "localhost",
      reader: {
        root: "http://localhost:3000", 
        api: "http://localhost:2000/api"
      },
      notes: {
        root: "http://localhost:8280", 
      },
      search: {
        root: "http://localhost:3000", 
      },
      budgeting: {
        root: "http://localhost:8280",
        api: "http://budget.cluster.local"
      },
      blob: {
        api: "http://localhost:2002/api"
      },
      central: {
        root: "http://localhost:3001", 
        api: "http://localhost:2001/api"
      }
    };
  }
}

export const { domain, reader, notes, search, budgeting, blob, central } = init();

export namespace Colors {
  const isDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
  const isLightMode = !isDarkMode;

  export namespace Base {
    export const black = '#444';
    export const white = '#fff';

    export const white1_5 = '#eee';

    export const black2 = '#666';
    export const white2 = '#ccc';

    export const lightBlack = '#999';
    export const lighterBlack = '#aaa';
    export const lightestBlack = '#bbb';

    export const whiteHover = '#f9f9f9';
    export const whiteActive = '#f1f1f1';

    export const blackHover = '#111';
    export const blackActive = '#111';

    export const lightGray = '#eeeeee';

    export const red = '#ef5350';
  }

  export namespace Text {
    export const base = isLightMode ? Base.black : Base.white;
    export const hover = isLightMode ? Base.blackHover : Base.whiteHover;
    export const active = isLightMode ? Base.blackActive : Base.whiteActive;

    export namespace Faint {
      export const base = isLightMode ? Base.black2 : Base.white2;
      export const hover = isLightMode ? Base.blackHover : Base.whiteHover;
      export const active = isLightMode ? Base.blackActive : Base.whiteActive;
    }

    export namespace Inverted {
      export const base = isDarkMode ? Base.black : Base.white;
      export const hover = isDarkMode ? Base.blackHover : Base.whiteHover;
      export const active = isDarkMode ? Base.blackActive : Base.whiteActive;
    }
  }

  export namespace Container {
    export const background = isLightMode ? Base.white : Base.black;
    export const border = isLightMode ? Base.black : Base.white;
    export const shadow = isLightMode ? Base.lightBlack : Base.lightBlack;
  }
}
