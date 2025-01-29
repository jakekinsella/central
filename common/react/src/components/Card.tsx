import styled from '@emotion/styled';

import { Colors } from '../constants';

export const Card = styled.div`
  width: 400px;
  height: 300px;
  background-color: ${Colors.Container.background};

  padding-top: 20px;
  padding-bottom: 20px;
  padding-left: 30px;
  padding-right: 30px;

  border: 1px solid ${Colors.Container.border};
  border-radius: 5px;

  box-shadow: 0px 0px 1px ${Colors.Container.shadow};
`;
