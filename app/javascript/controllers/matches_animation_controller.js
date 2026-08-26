import { Controller } from "@hotwired/stimulus";
import { gsap } from "gsap";

export default class extends Controller {
  connect() {
    const matches = this.element.querySelectorAll(".match");
    console.log("matches-animation connected", this.element.querySelectorAll(".match").length);
    gsap.from(matches, {
        opacity: 0,
        y: 300,
        duration: 0.8,
        stagger: 0.2,
        ease: "power2.out"
    });
  }
}