import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    // initialize empty values to 0
    if (this.inputTarget.value.trim() === "") {
      this.inputTarget.value = 0;
    }
  }

  decrement(event) {
    event.preventDefault();
    this.inputTarget.stepDown();
    this.inputTarget.dispatchEvent(new Event("change", { bubbles: true }));
  }

  increment(event) {
    event.preventDefault();
    this.inputTarget.stepUp();
    this.inputTarget.dispatchEvent(new Event("change", { bubbles: true }));
  }
}
