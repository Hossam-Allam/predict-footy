import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "team", "position", "input", "status"]
  static values = { locked: Boolean }

  connect() {
    this.updatePositions()
  }

  start(event) {
    if (this.lockedValue) return
    this.draggedTeam = event.currentTarget
    this.draggedTeam.classList.add("is-dragging")
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/plain", this.draggedTeam.dataset.teamId)
  }

  move(event) {
    if (this.lockedValue) return
    event.preventDefault()
    const overTeam = event.currentTarget

    if (!this.draggedTeam || overTeam === this.draggedTeam) return

    const bounds = overTeam.getBoundingClientRect()
    const insertAfter = event.clientY > bounds.top + bounds.height / 2
    this.listTarget.insertBefore(this.draggedTeam, insertAfter ? overTeam.nextSibling : overTeam)
    this.updatePositions()
  }

  drop(event) {
    if (!this.lockedValue) event.preventDefault()
  }

  finish() {
    if (!this.draggedTeam) return

    this.draggedTeam.classList.remove("is-dragging")
    this.statusTarget.textContent = `${this.draggedTeam.dataset.teamName} moved to position ${this.positionFor(this.draggedTeam)}.`
    this.draggedTeam = null
  }

  keyMove(event) {
    if (this.lockedValue || !event.target.closest(".table-prediction-handle")) return

    const team = event.currentTarget
    const moveUp = event.key === "ArrowUp"
    const moveDown = event.key === "ArrowDown"
    if (!moveUp && !moveDown) return

    event.preventDefault()
    const neighbour = moveUp ? team.previousElementSibling : team.nextElementSibling
    if (!neighbour) return

    this.listTarget.insertBefore(team, moveUp ? neighbour : neighbour.nextElementSibling)
    this.updatePositions()
    this.statusTarget.textContent = `${team.dataset.teamName} moved to position ${this.positionFor(team)}.`
  }

  updatePositions() {
    this.teamTargets.forEach((team, index) => {
      team.querySelector(".table-prediction-position").textContent = index + 1
      team.querySelector("input[name='team_ids[]']").value = team.dataset.teamId

      const actualPosition = Number.parseInt(team.dataset.currentPosition, 10)
      team.classList.remove("comparison-exact", "comparison-above", "comparison-below")
      if (Number.isNaN(actualPosition)) return

      team.classList.add(index + 1 < actualPosition ? "comparison-above" : index + 1 > actualPosition ? "comparison-below" : "comparison-exact")
    })
  }

  positionFor(team) {
    return this.teamTargets.indexOf(team) + 1
  }
}
