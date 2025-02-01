import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ["uploadButton"];

  connect() {
    setTimeout(() => {
      this.uploadButtonTarget.classList.remove("d-none");
    }, 500);
  }
}
