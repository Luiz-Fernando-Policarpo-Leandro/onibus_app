function initializePhoneListeners() {
  const addPhoneBtn = document.getElementById("add-phone");
  const phonesDiv = document.getElementById("phones");
  const phoneTemplate = document.getElementById("phone-template");

  if (!addPhoneBtn || !phonesDiv || !phoneTemplate) {
    return;
  }

  let nextNewIndex = Date.now();

  const addPhoneHandler = function (e) {
    e.preventDefault();
    let newPhoneHTML = phoneTemplate.innerHTML.replace(/NEW_INDEX/g, nextNewIndex);
    phonesDiv.insertAdjacentHTML("beforeend", newPhoneHTML);
    nextNewIndex++;
  };

  addPhoneBtn.removeEventListener("click", addPhoneHandler);
  addPhoneBtn.addEventListener("click", addPhoneHandler);

  // Ações de remover telefone
  const removePhoneHandler = function (e) {
    if (e.target.classList.contains("remove-phone")) {
      e.preventDefault();
      const phoneField = e.target.closest(".nested-fields");

      if (phoneField) {
        const destroyField = phoneField.querySelector(".destroy-field");

        if (destroyField) {
          const idField = phoneField.querySelector('input[id$="_id"]');
          if (idField && idField.value) { // É um registro existente
            destroyField.value = '1';
            phoneField.style.display = 'none';
            phoneField.classList.add('hidden-for-deletion');
          } else { // É um campo novo ou sem ID
            phoneField.remove();
          }
        } else {
          phoneField.remove();
        }
      }
    }
  };
  phonesDiv.removeEventListener("click", removePhoneHandler);
  phonesDiv.addEventListener("click", removePhoneHandler);
}

document.addEventListener("turbo:load", initializePhoneListeners);
