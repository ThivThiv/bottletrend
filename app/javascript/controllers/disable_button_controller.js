import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
  }

  disable() {
    const inputValue = Number(this.inputTarget.value)
    const stockValue = Number(this.stockTarget.innerHTML)
      if (inputValue > stockValue) {
        this.alertTarget.classList.remove('d-none')
      } else {
        this.element.setAttribute("disabled", "")
      }
    }
}
