import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("DOMContentLoaded", function() {
  const genreBoxes = document.querySelectorAll(".genre-box");

  genreBoxes.forEach(box => {
    box.addEventListener("click", function() {
      const currentlySelected = document.querySelector(".genre-box.selected");

      if (currentlySelected && currentlySelected !== box) {
        currentlySelected.classList.remove("selected");
        const hiddenCheckbox = document.getElementById(`genre_${currentlySelected.dataset.genreName}`);
        hiddenCheckbox.checked = false;
      }

      box.classList.toggle("selected");
      const hiddenCheckbox = document.getElementById(`genre_${box.dataset.genreName}`);
      hiddenCheckbox.checked = !hiddenCheckbox.checked;
    });
  });

  const createListButton = document.getElementById("create-list-button");

  createListButton.addEventListener("click", function() {
    // Additional logic or validation can be added here before submitting the form
    document.querySelector("form").submit();
  });
});
