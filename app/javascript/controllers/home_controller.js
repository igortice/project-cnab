import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ["uploadButton"];
  connect() {
    setTimeout(() => {
      this.uploadButtonTarget.style.display = "inline-block";
    }, 500);
  }
}
