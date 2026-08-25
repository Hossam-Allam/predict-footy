// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const updateThemeToggle = () => {
  const isDark = document.documentElement.dataset.theme === "dark"
  document.querySelectorAll("[data-theme-toggle]").forEach((button) => {
    button.querySelector(".theme-toggle-icon").textContent = isDark ? "☀" : "☾"
    button.querySelector(".theme-toggle-label").textContent = isDark ? "Light" : "Dark"
    button.setAttribute("aria-pressed", String(isDark))
  })
}

document.addEventListener("turbo:load", updateThemeToggle)
document.addEventListener("click", (event) => {
  const button = event.target.closest("[data-theme-toggle]")
  if (!button) return

  const nextTheme = document.documentElement.dataset.theme === "dark" ? "light" : "dark"
  document.documentElement.dataset.theme = nextTheme
  localStorage.setItem("footy-theme", nextTheme)
  updateThemeToggle()
})
