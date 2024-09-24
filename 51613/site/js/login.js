document.querySelector("form").addEventListener("submit", function (event) {
    event.preventDefault(); // Impede o comportamento padrão do formulário

    // Limpar mensagens de erro anteriores
    clearErrors();

    // Obter valores dos campos
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    // Obter dados salvos no localStorage
    const storedEmail = localStorage.getItem("email");
    const storedPassword = localStorage.getItem("password");

    let hasError = false;

    // Validação do e-mail
    if (email !== storedEmail) {
        displayError("emailError", "E-mail não encontrado.");
        hasError = true;
    }

    // Validação da senha
    if (password !== storedPassword) {
        displayError("passwordError", "Senha incorreta.");
        hasError = true;
    }

    // Se não houver erros, exibir a mensagem de sucesso
    if (!hasError) {
        displaySuccessMessage();

        // Redirecionar após 2 segundos
        setTimeout(function () {
            window.location.href = "index.html"; // Ajuste a URL da página principal
        }, 2000);
    }
});

// Função para exibir mensagens de erro
function displayError(elementId, message) {
    let errorElement = document.getElementById(elementId);

    // Se o elemento de erro não existir, criar um
    if (!errorElement) {
        errorElement = document.createElement("span");
        errorElement.id = elementId;
        errorElement.classList.add("error-message");
        const inputBox = document.getElementById(elementId.replace("Error", "")).parentNode;
        inputBox.appendChild(errorElement);
    }

    errorElement.textContent = message;
}

// Função para limpar mensagens de erro
function clearErrors() {
    const errorMessages = document.querySelectorAll(".error-message");
    errorMessages.forEach(function (element) {
        element.textContent = "";
    });
}

// Função para exibir a mensagem de sucesso
function displaySuccessMessage() {
    const continueButton = document.querySelector(".continue-button");
    let successMessage = document.createElement("div");

    successMessage.classList.add("success-message");
    successMessage.innerHTML = `
        <div style="display: flex; align-items: center; gap: 10px; color: green;font-weight: bold;font-size: 16px;">
            <span>&#10004;</span>
            <span>Login realizado com sucesso!</span>
        </div>
    `;

    // Inserir a mensagem de sucesso abaixo do botão "Entrar"
    continueButton.appendChild(successMessage);

    // Opcionalmente, remover a mensagem de sucesso após o redirecionamento
    setTimeout(() => {
        successMessage.remove();
    }, 2500);
}