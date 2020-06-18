import React, { useState } from "react";
import _ from "lodash";

import ErrorList from "../components/ErrorList";

const MissionForm = (props) => {
  const defaultForm = {
    title: "",
    description: ""
  }

  const [newMission, setNewMission] = useState(defaultForm)
  const [errors, setErrors] = useState({})

  const handleChange = (event) => {
    setNewMission({
      ...newMission,
      [event.currentTarget.name]: event.currentTarget.value
    })
  }

  const validForSubmission = () => {
    let submitErrors = {}
    const requiredFields = ["title", "description"]
    requiredFields.forEach((field) => {
      if (newMission[field].trim() === "") {
        submitErrors = {
          ...submitErrors,
          [field]: "is blank"
        }
      }
    })
    setErrors(submitErrors)
    return _.isEmpty(submitErrors)
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    if(validForSubmission()) {
      props.addNewMission(newMission)
    }
  }

  const clearForm = (event) => {
    setNewMission(defaultForm)
  }

  return (
    <form onSubmit={handleSubmit} className="callout">
      <ErrorList
        errors={errors}
      />

      <label htmlFor="title">
        Title:
        <input
          type="text"
          name="title"
          value={newMission.title}
          onChange={handleChange}
        />
      </label>

      <label htmlFor="description">
        Description:
        <input
          type="text"
          name="description"
          value={newMission.description}
          onChange={handleChange}
        />
      </label>

      <input type="submit" />
      <input type="button" onClick={clearForm} value="Clear"/>
    </form>
  )
}

export default MissionForm;
