import React from "react";

const MissionTile = (props) => {

  return (
    <div className="callout">
      <li>{props.mission.title}</li>
      <p>Submitted by: <i>{props.mission.user.full_name}</i></p>
    </div>
  )
}

export default MissionTile;
