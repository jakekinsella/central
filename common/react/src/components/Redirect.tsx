import React from 'react';

interface Props {
  to: string;
}

export function Redirect({ to }: Props) {
  window.location.href = to;
  return <div />;
}
