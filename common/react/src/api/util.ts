import { reader, central } from '../constants';

const apiRequest = async (uri: string, options: any) => {
  const response = await fetch(uri, options);
  if (response.status === 403) {
    window.location.href = "/login";
  }

  return response;
}

export namespace Reader {
  export const request = async (uri: string, options: any) => {
    return apiRequest(`${reader.api}${uri}`, options);
  }
}

export namespace Central {
  export const request = async (uri: string, options: any) => {
    return apiRequest(`${central.api}${uri}`, options);
  }
}
