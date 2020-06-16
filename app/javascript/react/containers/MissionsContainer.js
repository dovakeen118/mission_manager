import React, { useState, useEffect, Fragment } from "react";
import { Link } from "react-router-dom";

import MissionTile from "../components/MissionTile";

const MissionsContainer = (props) => {
  const [missions, setMissions] = useState([])

  useEffect(() => {
    fetch('/api/v1/missions')
    .then((response) => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${reponse.status} (${reponse.statusText})`;
        let error = new Error(errorMessage);
        throw error;
      }
    })
    .then((response) => response.json())
    .then((body) => {
      setMissions(body.missions)
    })
    .catch((error) => console.error(`Error in fetch: ${error.message}`));
  }, []);

  let missionTiles;

  if (missions.length === 0) {
    missionTiles = <p>No missions have been submitted</p>
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
      <h3>
        <Link to="/missions/new">Submit a new Mission</Link>
      </h3>

      <div className="callout secondary">
        {missionTiles}
      </div>
    </div>
  )
}

export default MissionsContainer;
