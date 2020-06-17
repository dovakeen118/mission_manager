import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

import MissionsListContainer from "../containers/MissionsListContainer"
import MissionShowContainer from "../containers/MissionShowContainer"

const App = (props) => {
  return (
    <div>
      <BrowserRouter>
        <Switch>
          <Route exact path="/missions" component={MissionsListContainer} />
          <Route exact path="/missions/:id" component={MissionShowContainer} />
        </Switch>
      </BrowserRouter>
    </div>
  )
}

export default App;
