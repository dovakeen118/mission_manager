import React from "react";
import { BrowserRouter, Link } from "react-router-dom";
import Enzyme, { mount } from "enzyme";
import Adapter from "enzyme-adapter-react-16";
Enzyme.configure({ adapter: new Adapter() })

import MissionTile from "./MissionTile";

describe("MissionTile", () => {
  let wrapper;
  let user = {
    email: "test@email.com",
    full_name: "Naruto",
    role: "user"
  }

  let mission = {
    id: 1,
    title: "Test Title",
    description: "Test Description",
    createdTimestamp: "June 18, 2020",
    user: user
  }

  beforeEach(() => {
    wrapper = mount(
      <BrowserRouter>
        <MissionTile
          key={1}
          mission={mission}
        />
      </BrowserRouter>
    )
  })

  it("should render a link to the show page /missions/1", () => {
    expect(wrapper.find("Link").props()["to"]).toBe("/missions/1")
  })

  it("should render the link displaying the title", () => {
    expect(wrapper.find("Link").text()).toBe("Test Title")
  })

  it("should render the title as an li element within the link", () => {
    expect(wrapper.find("li").text()).toBe("Test Title")
  })

  it("should render a p element containing the user full name", () => {
    expect(wrapper.find("p").text()).toContain("Naruto")
  })
})
