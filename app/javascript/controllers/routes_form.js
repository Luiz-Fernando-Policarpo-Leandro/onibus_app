document.addEventListener('DOMContentLoaded', () => {
  const addRotaButton = document.getElementById('add-rota-button');
  const rotasFormContainer = document.getElementById('rotas-form-container');
  const template = document.getElementById('rota-fields-template');

  addRotaButton.addEventListener('click', () => {
    const newFields = document.importNode(template.content, true);
    const newForm = newFields.querySelector('.rota-fields');

    const uniqueId = new Date().getTime();
    const newHtml = newForm.outerHTML.replace(/NEW_RECORD/g, uniqueId);

    const tempDiv = document.createElement('div');
    tempDiv.innerHTML = newHtml;

    rotasFormContainer.appendChild(tempDiv.firstChild);
  });

  // Função para remover campos de rota
  rotasFormContainer.addEventListener('click', (e) => {
    if (e.target.classList.contains('remove-rota-button')) {
      const rotaField = e.target.closest('.rota-fields');
      if (rotaField) {
        const destroyField = rotaField.querySelector('input[name*="_destroy"]');
        if (destroyField) {
          // Se o campo já existe no banco, apenas o marca para ser destruído
          destroyField.value = '1';
          rotaField.style.display = 'none'; // Oculta o campo
        } else {
          // Se o campo é novo, remove-o completamente do DOM
          rotaField.remove();
        }
      }
    }
  });
});
