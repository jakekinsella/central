import React from 'react';

interface Props {
  icon: string;
  size?: string;
}

export function Icon({ icon, size = "1em" }: Props) {
  return (
    <span className="material-icons" style={{ fontSize: size }}>
      {icon}
    </span>
  );
}
