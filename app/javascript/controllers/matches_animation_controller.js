import { Controller } from "@hotwired/stimulus";
import { gsap } from "gsap";

export default class extends Controller {
  connect() {
    const matches = this.element.querySelectorAll(".match");
    console.log("matches-animation connected", this.element.querySelectorAll(".match").length);
    gsap.from(matches, {
        opacity: 0,
        x: 200,
        duration: 0.6,
        stagger: 0.2,
        ease: "back.inout"
    });
  }
}