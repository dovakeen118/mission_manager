import React from "react";
import { Link } from "react-router-dom";

const MissionShow = (props) => {
  let userLink =
    <Link to={`/users/${props.mission.user.id}`}>
      {props.mission.user.full_name}
    </Link>

  return (
    <div className="callout">
      <h3>{props.mission.title}</h3>
      <p id="mission-description">{props.mission.description}</p>
      <p id="mission-user">Submitted by: <i>{userLink}</i></p>
      <p id="mission-created-timestamp">Submitted at: {props.mission.createdTimestamp}</p>
    </div>
  )
}

export default MissionShow;
