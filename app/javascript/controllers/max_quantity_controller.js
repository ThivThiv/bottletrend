import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["input", "alert"]
  static values = ["domain", "users"]

  connect() {
    console.log(this.domainValue)
  }

  available() {
    const inputValue = Number(this.inputTarget.value)
    const stockValue = Number(this.domainValue) + Number(this.usersValue)
      if (inputValue > stockValue) {
        this.alertTarget.classList.remove('d-none')
      } else {
        this.alertTarget.classList.add('d-none')
      }
    }
}
