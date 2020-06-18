import React from "react";
import Enzyme, { mount } from "enzyme";
import Adapter from "enzyme-adapter-react-16";
Enzyme.configure({ adapter: new Adapter() })

import ErrorList from "./ErrorList";

describe("ErrorList", () => {
  let wrapper;
  let errors = {
    title: "can't be blank",
    description: "can't be blank",
    field: "Invalid Email or password"
  }

  beforeEach(() => {
    wrapper = mount(
      <ErrorList
        errors={errors}
      />
    )
  })

  it("should render an li element containing an error", () => {
    expect(wrapper.find("li").first().text()).toBe("Title can't be blank")
  })

  it("should render an li element for all errors provided", () => {
    expect(wrapper.find("li").length).toBe(3)
  })
})
