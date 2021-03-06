import React from "react";
import { Link } from "react-router-dom";

const MissionTile = (props) => {

  return (
    <div className="callout">
      <Link to={`/missions/${props.mission.id}`}>
        <li>{props.mission.title}</li>
      </Link>

      <p>Submitted by: {props.mission.user.full_name}</p>
    </div>
  )
}

export default MissionTile;
