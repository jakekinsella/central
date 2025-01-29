import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import styled from '@emotion/styled';

import Login from './components/Login';

import { Colors } from './constants';

const Root = styled.div`
  position: relative;
  display: flex;

  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;

  color: ${Colors.Text.base};
  font-family: 'Roboto', sans-serif;
  font-weight: 100;
`;

function App() {
  return (
    <Root>
      <Router>
        <Routes>
          <Route path="/login" element={<Login />} />
        </Routes>
      </Router>
    </Root>
  );
}

export default App;
