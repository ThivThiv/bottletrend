import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["modal"]

  connect() {
    console.log(this.totoTarget)
  }

  displayModal () {
    // this.modalTarget.style.backgroundColor = "green"
    console.log(this.modalTarget)
    this.modalTarget.classList.add("active")
  }
}
