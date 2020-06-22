import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

import MissionsListContainer from "../containers/MissionsListContainer"
import MissionShowContainer from "../containers/MissionShowContainer"
import NewMissionContainer from "../containers/NewMissionContainer"
import UserDetailContainer from "../containers/UserDetailContainer"

const App = (props) => {
  return (
    <div>
      <BrowserRouter>
        <Switch>
          <Route exact path="/missions" component={MissionsListContainer} />
          <Route exact path="/missions/new" component={NewMissionContainer} />
          <Route exact path="/missions/:id" component={MissionShowContainer} />
          <Route exact path="/users/:id" component={UserDetailContainer} />
        </Switch>
      </BrowserRouter>
    </div>
  )
}

export default App;
