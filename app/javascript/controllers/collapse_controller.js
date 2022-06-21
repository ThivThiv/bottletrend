import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["buyopen", "sellopen"]

  connect() {
    console.log("hello")
  }

  openb() {
    this.buyopenTarget.classList.toggle('active')
  }

  opens() {
    this.sellopenTarget.classList.toggle('active')
  }

}
