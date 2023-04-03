import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs" // Add this line, to access the sortablejs library
import { FetchRequest } from '@rails/request.js'

// Connects to data-controller="sortable"
export default class extends Controller {
  // console.log("Sortable controller connected") //# I add this for testing purposes. Once everything is working you can comment this out.

  static values = {
    url: String,
    test: String
  }

  connect() {
    console.log("Sortable controller connected")
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      ghostClass: "sortable-ghost",
      chosenClass: "sortable-chosen",
      dragClass: "sortable-drag",
      onEnd: this.end.bind(this)
    })
  }

  async end(event) {
    console.log("Sortable onEnd triggered")
    console.log(event)
    // console.log(`${event.oldIndex + 1} -> ${event.newIndex + 1}`)
    // console.log(`${this.urlValue}?old_position=${event.oldIndex + 1}&new_position=${event.newIndex + 1}`)

    const request = new FetchRequest('patch', `${this.urlValue}?old_position=${event.oldIndex + 1}&new_position=${event.newIndex + 1}`)
    const response = await request.perform()
    console.log(response)
  }

}
