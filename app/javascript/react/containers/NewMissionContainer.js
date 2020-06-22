import React, { useState } from "react";
import { Link, Redirect } from "react-router-dom";

import MissionFormContainer from "./MissionFormContainer";

const NewMissionContainer = (props) => {
  const [redirect, setRedirect] = useState(false)
  const [missionId, setMissionId] = useState(null)
  const [signIn, setSignIn] = useState(false)

  const addNewMission = (formPayload) => {
    fetch("/api/v1/missions", {
      credentials: "same-origin",
      method: "POST",
      body: JSON.stringify(formPayload),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      }
    })
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
      if (body.mission) {
        setMissionId(body.mission.id)
        setRedirect(true)
      } else if (body.invalid) {
        setSignIn(true)
      }
    })
    .catch((error) => console.error(`Error in fetch submitting new mission: ${error.message}`));
  }

  if (redirect) {
    return <Redirect to={`/missions/${missionId}`} />
  }

  let signInError;

  if (signIn) {
    signInError =
      <h3>Please <i><a href="/users/sign_in">Sign In</a></i> or <i><a href="/users/sign_up">Sign Up</a></i> to continue</h3>
  }

  return (
    <div className="callout">
      <h1>Submit a New Mission</h1>

      {signInError}

      <i className="fa fa-chevron-left">
        <Link to="/missions">
          Back to All Missions
        </Link>
      </i>

      <MissionFormContainer
        addNewMission={addNewMission}
      />
    </div>
  )
}

export default NewMissionContainer;
