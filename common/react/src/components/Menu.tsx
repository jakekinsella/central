import React from 'react';
import styled from '@emotion/styled';

import { Colors } from '../constants';

const FloatingMenu = styled.div`
  position: relative;
  width: 100%;
  height: 100%;

  z-index: 11;
`;

const MenuContainer = styled.div`
  position: absolute;

  width: 150px;

  background-color: ${Colors.Container.background};

  border: 1px solid ${Colors.Container.border};
  border-radius: 5px;
`;

const MenuItem = styled.div`
  padding-top: 10px;
  padding-bottom: 10px;
  padding-left: 10px;
  padding-right: 10px;

  display: flex;

  border-radius: 3px;

  cursor: pointer;

  &:hover {
    background-color: ${Colors.Text.Inverted.hover};
  }

  &:active {
    background-color: ${Colors.Text.Inverted.active};
  }
`;

interface Props {
  show: Boolean;
  items: { text: string, onClick: () => void }[];
  top?: number;
  right?: number;
}

export function Menu({ show, items, top = -9, right = 10 }: Props) {
  return (
    <FloatingMenu>
      <MenuContainer style={{ visibility: show ? "visible" : "hidden", top: `${top}px`, right: `${right}px` }}>
        {items.map(({text, onClick}) => {
          return <MenuItem onClick={(event) => { event.stopPropagation(); event.preventDefault(); onClick(); }}>{text}</MenuItem>
        })}
      </MenuContainer>
    </FloatingMenu>
  );
}
