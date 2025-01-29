import styled from '@emotion/styled';

import { Colors } from '../constants';

export const Textbox = styled.input`
  display: block;
  box-sizing: border-box;

  width: 100%;
  height: 35px;

  padding-left: 10px;
  padding-right: 10px;

  border: 1px solid ${Colors.Container.border};
  border-radius: 3px;

  background: transparent;
  color: ${Colors.Text.base};

  font-size: 15px;
  font-family: 'Roboto', sans-serif;
  font-weight: 100;
`;