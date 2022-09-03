import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  shuffle(event) {
    let target = event.currentTarget;
    let playlist = target.getAttribute("data-amplitude-playlist");
    shuffle.setAttribute("data-amplitude-playlist", playlist);
  }

  showPlayer() {
    let player = document.getElementById("player-audio");
    if (player.classList.contains("hidden")) {
      player.classList.remove("hidden");
    }
  }
}
