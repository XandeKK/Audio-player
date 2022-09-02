import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let songs = JSON.parse(this.element.getAttribute("data-item-playlist-param"))
    let playlist = this.element.getAttribute("data-name-playlist")
    
    Amplitude.addPlaylist( playlist, "", songs );
    Amplitude.bindNewElements();
  }
}
