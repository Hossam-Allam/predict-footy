document.addEventListener("turbo:frame-missing", async (event) => {
    // stop Turbo's default "Content missing" injection
    event.preventDefault();

    // simple custom message:
    event.target.innerHTML = `
    <div class="turbo-frame-error-custom">
      <h3>Sorry Match has already started</h3>
      <p><a href="/">go home</a>.</p>
    </div>
  `;

    // --or-- inspect the failed response and show different UIs:
    // const { response } = event.detail;
    // const html = await response.text();
    // if (response.status === 404) { ... }
    // event.detail.render(event.target, new DOMParser().parseFromString(html, "text/html"));
});