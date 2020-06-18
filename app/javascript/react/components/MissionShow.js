import React from "react";

const MissionShow = (props) => {

  return (
    <div className="callout">
      <h3>{props.mission.title}</h3>
      <p id="mission-description">{props.mission.description}</p>
      <p id="mission-user">Submitted by: {props.mission.user.full_name}</p>
      <p id="mission-created-timestamp">Submitted at: {props.mission.createdTimestamp}</p>
    </div>
  )
}

export default MissionShow;
