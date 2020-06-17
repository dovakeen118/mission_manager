import React from "react";

const MissionShow = (props) => {

  return (
    <div className="callout">
      <h3>{props.mission.title}</h3>
      <p>{props.mission.description}</p>
      <p>Submitted by: {props.mission.user.full_name}</p>
      <p>Submitted at: {props.mission.createdTimestamp}</p>
    </div>
  )
}

export default MissionShow;
