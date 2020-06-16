import React from 'react';
import { BrowserRouter, Route } from 'react-router-dom';

import MissionsContainer from "../containers/MissionsContainer"

const App = (props) => {
  return (
    <div>
      <BrowserRouter>
        <Route exact path="/missions" component={MissionsContainer} />
      </BrowserRouter>
    </div>
  )
}

export default App;
