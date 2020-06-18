import React, { useState, useEffect, Fragment } from "react";
import { Link } from "react-router-dom";

import MissionTile from "../components/MissionTile";

const MissionsContainer = (props) => {
  const [missions, setMissions] = useState([])
  const [session, setSession] = useState(false)

  useEffect(() => {
    fetch('/api/v1/missions')
    .then((response) => {
      if (response.ok) {
        return response.json();
      } else {
        let errorMessage = `${response.status} (${response.statusText})`;
        let error = new Error(errorMessage);
        throw error;
      }
    })
    .then((body) => {
      setMissions(body.missions)
      setSession(body.missions[0].session)
    })
    .catch((error) => console.error(`Error in fetch for missions: ${error.message}`));
  }, []);

  let newMissionLink;

  if (session) {
    newMissionLink =
      <h3>
        <Link to="/missions/new">
          Submit a new Mission
        </Link>
      </h3>
  } else {
    newMissionLink =
    <h3>Please <i><a href="/users/sign_in">Sign In</a></i> or <i><a href="/users/sign_up">Sign Up</a></i> to contribute</h3>
  }

  let missionTiles;

  if (missions.length === 0) {
    missionTiles = <p><i>No missions have been submitted</i></p>
  } else {
    missionTiles = missions.map((mission) => {
      return (
        <MissionTile
          key={mission.id}
          mission={mission}
        />
      )
    })
  }

  return (
    <div>
      <h1>All Missions</h1>

      {newMissionLink}

      <div className="callout secondary">
        {missionTiles}
      </div>
    </div>
  )
}

export default MissionsContainer;
