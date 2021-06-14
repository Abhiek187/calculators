import { configure, shallow, ShallowWrapper } from "enzyme";
import Adapter from "enzyme-adapter-react-16";
import React from "react";
import Calculator from "./Calculator";

configure({ adapter: new Adapter() });

describe("Calculator", () => {
    let wrapper: ShallowWrapper;

    beforeEach(() => {
        wrapper = shallow(<Calculator />);
    });

    afterEach(() => {
        // Clear the output after each test
        wrapper.find("RoundButton[text='clear']").simulate("press");
    });

    it("solves a simple equation", () => {
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("");

        wrapper.find("RoundButton[text='2']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("2");

        wrapper.find("RoundButton[text='+']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("2 + ");

        wrapper.find("RoundButton[text='3']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("2 + 3");

        wrapper.find("RoundButton[text='=']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("5");
    });

    it("solves a complex equation", () => {
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("");

        wrapper.find("RoundButton[text='(-)']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-");

        wrapper.find("RoundButton[text='0']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0");

        wrapper.find("RoundButton[text='.']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0.");

        wrapper.find("RoundButton[text='1']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0.1");

        wrapper.find("RoundButton[text='*']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0.1 * ");

        wrapper.find("RoundButton[text='7']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0.1 * 7");

        wrapper.find("RoundButton[text='=']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0.7000000000000001");

        wrapper.find("RoundButton[text='/']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0.7000000000000001 / ");

        wrapper.find("RoundButton[text='2']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0.7000000000000001 / 2");

        wrapper.find("RoundButton[text='=']").simulate("press");
        expect(wrapper.find("Text[numberOfLines=2]").render().text()).toBe("-0.35000000000000003");
    });
});
