import styled from '@emotion/styled';

import { Colors } from '../constants';

export const Submit = styled.button`
  width: 100%;
  height: 40px;

  cursor: pointer;

  border: 1px solid ${Colors.Container.border};
  border-radius: 5px;

  background-color: ${Colors.Container.background};

  font-size: 18px;
  font-family: 'Roboto', sans-serif;
  font-weight: 100;

  color: ${Colors.Text.base};

  &:hover {
    background-color: ${Colors.Text.Inverted.hover};
  }

  &:active {
    background-color: ${Colors.Text.Inverted.active};
  }
`;
