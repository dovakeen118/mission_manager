import React, { Fragment } from "react";
import { Link } from "react-router-dom"

const UserDetail = (props) => {
  let image = props.user.image ? props.user.image.url : null

  let missions;

  if (props.user.missions.length > 0) {
    missions = props.user.missions.map((mission) => {
      return (
        <li key={mission.id}>
          <Link to={`/missions/${mission.id}`}>
            {mission.title}
          </Link>
        </li>
      )
    })
  } else {
    missions = <p>No Missions</p>
  }

  return (
    <>
      <img
        className="profile-image"
        src={image}
        alt={props.user.full_name}
      />

      <h1>{props.user.full_name}</h1>
      <h4 id="user-email">email: {props.user.email}</h4>
      <h4 id="user-role">role: {props.user.role}</h4>

      <div className="callout">
        <h3>Missions</h3>
        {missions}
      </div>
    </>
  )
}

export default UserDetail;
