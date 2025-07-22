document.addEventListener("DOMContentLoaded", () => {
  const addPhoneBtn = document.getElementById("add-phone");
  const phonesDiv = document.getElementById("phones");
  const phoneTemplate = document.getElementById("phone-template").innerHTML;

  let index = 1;

  addPhoneBtn.addEventListener("click", function (e) {
    e.preventDefault();
    let newPhoneHTML = phoneTemplate.replace(/NEW_INDEX/g, index);
    phonesDiv.insertAdjacentHTML("beforeend", newPhoneHTML);
    index++;
  });

  phonesDiv.addEventListener("click", function (e) {
    if (e.target.classList.contains("remove-phone")) {
      e.preventDefault();
      e.target.closest(".field").remove();
    }
  });
});
