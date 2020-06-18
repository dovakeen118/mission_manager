import React from "react";
import Enzyme, { mount } from "enzyme";
import Adapter from "enzyme-adapter-react-16";
Enzyme.configure({ adapter: new Adapter() })

import MissionShow from "./MissionShow";

describe("MissionShow", () => {
  let wrapper;
  let user = { email: "test@email.com", full_name: "Naruto", role: "user" }
  let mission = {
    title: "Test Title",
    description: "Test Description",
    createdTimestamp: "June 18, 2020",
    user: user
  }

  beforeEach(() => {
    wrapper = mount(
      <MissionShow
        mission={mission}
      />
    )
  })

  it("should render a h3 element containing the title", () => {
    expect(wrapper.find("h3").text()).toBe("Test Title")
  })

  it("should render 3 p elements", () => {
    expect(wrapper.find("p").length).toBe(3)
  })

  it("should render a p element containing the description", () => {
    expect(wrapper.find("#mission-description").text()).toBe("Test Description")
  })

  it("should render a p element containing the user full name", () => {
    expect(wrapper.find("#mission-user").text()).toContain("Naruto")
  })

  it("should render a p element containing the formatted created at timestamp", () => {
    expect(wrapper.find("#mission-created-timestamp").text()).toContain("June 18, 2020")
  })
})
