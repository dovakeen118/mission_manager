import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";

import MissionShow from "../components/MissionShow";

const MissionShowContainer = (props) => {
  const [mission, setMission] = useState({
    id: null,
    title: null,
    description: null,
    createdTimestamp: null,
    user: {}
  })

  useEffect(() => {
    let id = props.match.params.id
    fetch(`/api/v1/missions/${id}`)
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
      setMission({
        id: body.mission.id,
        title: body.mission.title,
        description: body.mission.description,
        createdTimestamp: body.mission.created_at,
        user: body.mission.user
      })
    })
    .catch((error) => console.error(`Error in fetch for mission: ${error.message}`));
  }, [])

  let missionShow;

  if (mission.id === null) {
    missionShow = <p>Sorry, no mission was found</p>
  } else {
    missionShow =
      <MissionShow
        mission={mission}
      />
  }

  return (
    <div className="callout">
      <h1>Selected Mission</h1>

      <i className="fa fa-chevron-left">
        <Link to="/missions">
          Back to All Missions
        </Link>
      </i>

      {missionShow}
    </div>
  )
}

export default MissionShowContainer;
