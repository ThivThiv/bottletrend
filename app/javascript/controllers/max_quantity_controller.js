import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["input", "alert", "sale"]
  static values = {
    stock: Number,
    user: Number
  }

  connect() {
    this.saleTarget.value = ""
  }

  available() {
    const inputValue = Number(this.inputTarget.value)
    const stockValue = Number(this.stockValue)

      if (inputValue > stockValue) {
        this.alertTarget.classList.remove('d-none')
      } else {
        this.alertTarget.classList.add('d-none')
      }
    }

  stock() {
    const saleValue = Number(this.saleTarget.value)
    const userValue = Number(this.userValue)


    if (saleValue > userValue) {
      this.alertTarget.classList.remove('d-none')
    } else {
      this.alertTarget.classList.add('d-none')
    }
  }
}
