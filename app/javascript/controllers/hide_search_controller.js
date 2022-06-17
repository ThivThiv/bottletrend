// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {


  connect() {
    this.prevScrollpos = window.pageYOffset;
  }

  hideScroll() {
    const currentScrollPos = window.pageYOffset;
    if (this.prevScrollpos > currentScrollPos) {
      this.element.style.top = "0";
    } else {
      this.element.style.top = "-60px";
    }
    this.prevScrollpos = currentScrollPos;
}
}
