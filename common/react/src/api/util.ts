import { reader, blob, budgeting, central } from '../constants';
import { Users } from './users';

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

export namespace Blob {
  export const request = async (uri: string, options: any) => {
    return apiRequest(`${blob.api}${uri}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        'authentication': `Bearer ${Users.token()}`
      }
    });
  }
}

export namespace Budgeting {
  export const request = async (uri: string, options: any) => {
    return apiRequest(`${budgeting.api}${uri}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': Users.token()
      }
    });
  }
}

export namespace Central {
  export const request = async (uri: string, options: any) => {
    return apiRequest(`${central.api}${uri}`, options);
  }
}
