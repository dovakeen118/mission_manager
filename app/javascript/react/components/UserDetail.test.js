import React from "react";
import { BrowserRouter, Link } from "react-router-dom";
import Enzyme, { mount } from "enzyme";
import Adapter from "enzyme-adapter-react-16";
Enzyme.configure({ adapter: new Adapter() })

import UserDetail from "./UserDetail";

describe("UserDetail", () => {
  let wrapper;

  let user = {
    id: 1,
    email: "test@email.com",
    full_name: "Naruto",
    role: "user",
    image: {
      url: "test.png"
    },
    missions: [
      {
        id: 1,
        title: "Test Title",
        description: "Test Description",
        createdTimestamp: "June 18, 2020"
      }
    ]
  }

  beforeEach(() => {
    wrapper = mount(
      <BrowserRouter>
        <UserDetail
          user={user}
        />
      </BrowserRouter>
    )
  })

  it("should render an img element containing the profile image", () => {
    expect(wrapper.find("img").props()["src"]).toEqual("test.png")
  })

  it("should render a h1 element containing the full name", () => {
    expect(wrapper.find("h1").text()).toContain("Naruto")
  })

  it("should render a h4 element containing the email", () => {
    expect(wrapper.find("#user-email").text()).toContain("test@email.com")
  })

  it("should render a h4 element containing the role", () => {
    expect(wrapper.find("#user-role").text()).toContain("user")
  })

  it("should render a li element for each mission", () => {
    expect(wrapper.find("li").length).toBe(1)
  })

  it("should render a li element displaying the title", () => {
    expect(wrapper.find("li").text()).toBe("Test Title")
  })

  it("should render the title as a link within the li", () => {
    expect(wrapper.find("Link").text()).toBe("Test Title")
  })

  it("should render a link to the mission show page /missions/1", () => {
    expect(wrapper.find("Link").props()["to"]).toBe("/missions/1")
  })
})
