import { Controller } from "@hotwired/stimulus";
import { gsap } from "gsap";

export default class extends Controller {
  connect() {
    const matches = this.element.querySelectorAll(".match");
    console.log("matches-animation connected", this.element.querySelectorAll(".match").length);
    gsap.from(matches, {
        opacity: 0,
        y: 200,
        duration: 0.8,
        stagger: 0.1,
        ease: "back.out"
    });
  }
}