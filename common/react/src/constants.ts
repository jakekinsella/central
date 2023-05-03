interface EndpointDefinition {
  domain: string;
  reader: { root: string, api: string };
  central: { root: string, api: string };
}

const init = () : EndpointDefinition => {
  if (window.location.host.includes("localhost")) {
    return {
      domain: "localhost",
      reader: {
        root: "https://reader.localhost", 
        api: "https://reader.localhost/api"
      },
      central: {
        root: "https://central.localhost", 
        api: "https://central.localhost/api"
      }
    };
  } else if (window.location.protocol === "https:") {
    return {
      domain: "jakekinsella.com",
      reader: {
        root: "https://reader.jakekinsella.com", 
        api: "https://reader.jakekinsella.com/api"
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
      central: {
        root: "http://localhost:3001", 
        api: "http://localhost:2001/api"
      }
    };
  }
}

export const { domain, reader, central } = init();

export const colors = {
  black: '#444',
  black2: '#666',
  lightBlack: '#999',
  lighterBlack: '#aaa',
  lightestBlack: '#bbb',

  whiteHover: '#f9f9f9',
  whiteActive: '#f1f1f1',

  lightGray: '#eeeeee',

  red: '#ef5350'
};
