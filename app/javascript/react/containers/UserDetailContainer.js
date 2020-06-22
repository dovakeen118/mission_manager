import React, { useState, useEffect } from "react"

import UserDetail from "../components/UserDetail"

const UserDetailContainer = (props) => {
  const [user, setUser] = useState({
    full_name: null,
    email: null,
    role: null,
    image: null,
    missions: []
  })

  useEffect(() => {
    let id = props.match.params.id
    fetch(`/api/v1/users/${id}`)
    .then((response) => {
      if (response.ok) {
        return response.json()
      } else {
        let errorMessage = `${response.status} (${response.statusText})`;
        let error = new Error(errorMessage);
        throw error;
      }
    })
    .then((body) => {
      setUser({
        full_name: body.user.full_name,
        email: body.user.email,
        role: body.user.role,
        image: body.user.profile_image,
        missions: body.user.missions
      })
    })
    .catch((error) => console.error(`Error in fetch for user: ${error.message}`));
  }, [])

  let userDetail;

  if (user) {
    userDetail =
      <UserDetail
        user={user}
      />
  } else {
    userDetail = <p>Sorry, no user was found</p>
  }

  return (
    <div className="callout">
      {userDetail}
    </div>
  )
}

export default UserDetailContainer;
