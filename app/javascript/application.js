// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function formatLocalTimes() {
  document.querySelectorAll("[data-utc-time]").forEach((element) => {
    const date = new Date(element.dataset.utcTime)

    element.textContent = new Intl.DateTimeFormat(undefined, {
      month: "short",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit"
    }).format(date)
  })
}

document.addEventListener("turbo:load", formatLocalTimes)
document.addEventListener("turbo:frame-load", formatLocalTimes)
document.addEventListener("turbo:before-stream-render", (event) => {
  const originalRender = event.detail.render
  event.detail.render = (streamElement) => {
    originalRender(streamElement)
    formatLocalTimes()
  }
})
