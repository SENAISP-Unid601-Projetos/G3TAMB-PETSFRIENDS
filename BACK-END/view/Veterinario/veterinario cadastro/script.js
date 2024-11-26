async function cadastraCliente() {
    const nome = document.querySelector("#nome");
    const crmv = document.querySelector("#crmv");
    const cpf = document.querySelector("#cpf");
    const email = document.querySelector("#email");
    const senha = document.querySelector("#password");
    fetch("/cadastra_vet", {
        method:"POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: `
        {
            "nome":"${nome.value}",
            "cpf":"${cpf.value}",
            "crmv":"${crmv.value}",
            "email":"${email.value}",
            "senha":"${senha.value}"
        }
        ` 
    })
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        console.log(dados);
        if (dados.sucesso === false) {
            throw "Veterinário não cadastrado.\nMotivo: " + dados.motivoErro.detail;
        }
        alert("Cadastro feito com sucesso!");
        open("login_veterinario", "_self");
    })
    .catch( (erro) => {
        alert(erro);
    });
}

window.addEventListener("DOMContentLoaded", () => {
    const botaoEnvia = document.querySelector("#botaoEnvia");
    
    botaoEnvia.addEventListener("click", () => {
        const campos = document.querySelectorAll("input");
        const senha = document.querySelector("#password");
        const confirmaSenha = document.querySelector("#confirmPassword");
        let camposPreenchidos = 0;

        campos.forEach( (campo) => {
            if (campo.value != "") {
                camposPreenchidos++;
            }
        })

        if (camposPreenchidos != campos.length) {
            alert("Favor preencher todos os campos!");
        }
        else if (senha.value != confirmaSenha.value) {
            alert("As senhas preenchidas não correspondem!");
        }
        else {
            cadastraCliente();
        }
    })
})

// Função para mostrar ou esconder o balão com as opções
function toggleOptions() {
    var options = document.getElementById("options");
    if (options.style.display === "none" || options.style.display === "") {
      options.style.display = "block"; // Exibe o balão com as opções
    } else {
      options.style.display = "none"; // Oculta o balão
    }
  }


/*
document.getElementById("registerForm").addEventListener("submit", function (event) {
    event.preventDefault(); // Evita o envio padrão do formulário

    // Limpar mensagens de erro anteriores
    clearErrors();

    let hasError = false;

    const fullName = document.getElementById("fullName").value;
    const email = document.getElementById("email").value;
    const cpf = document.getElementById("cpf").value;
    const dateOfBirth = document.getElementById("dateOfBirth").value;
    const phone = document.getElementById("number").value;
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    // Validação de idade (maior de 18 anos)
    if (!isAdult(dateOfBirth)) {
        displayError("dobError", "Você deve ter 18 anos ou mais para se cadastrar.");
        hasError = true;
    }

    // Validação de CPF (apenas se precisar validar o formato ou números válidos)
    if (!isValidCPF(cpf)) {
        displayError("cpfError", "CPF inválido.");
        hasError = true;
    }

    // Validação de senha
    if (password !== confirmPassword) {
        displayError("confirmPasswordError", "As senhas não correspondem.");
        hasError = true;
    }

    // Validação do número de celular
    const phonePattern = /^\(?\d{2}\)?\s?\d{4,5}-\d{4}$/;
    if (!phonePattern.test(phone)) {
        displayError("numberError", "Número de celular inválido.");
        hasError = true;
    }

    // Caso não haja erro, salvar as informações no localStorage e mostrar mensagem de sucesso
    if (!hasError) {
        // Salvar dados no localStorage
        localStorage.setItem("fullName", fullName);
        localStorage.setItem("email", email);
        localStorage.setItem("cpf", cpf);
        localStorage.setItem("dateOfBirth", dateOfBirth);
        localStorage.setItem("phone", phone);
        localStorage.setItem("password", password);

        // Exibir mensagem de sucesso
        document.getElementById("successMessage").style.display = "block";

        // Redirecionar para a página de login após 2 segundos
        setTimeout(function () {
            window.location.href = "login.html";
        }, 2500); // Aguarda 2 segundos
    }
});

// Função para verificar se a pessoa é maior de 18 anos
function isAdult(dateOfBirth) {
    const birthDate = new Date(dateOfBirth);
    const today = new Date();
    const age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    const dayDiff = today.getDate() - birthDate.getDate();

    return age > 18 || (age === 18 && (monthDiff > 0 || (monthDiff === 0 && dayDiff >= 0)));
}

// Função para validar o CPF (simplificada)
function isValidCPF(cpf) {
    cpf = cpf.replace(/[^\d]+/g,''); // Remove caracteres não numéricos
    if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) return false; // Verifica se o CPF tem 11 dígitos ou se todos os dígitos são iguais
    
    let soma = 0, resto;
    for (let i = 1; i <= 9; i++) soma += parseInt(cpf.substring(i-1, i)) * (11 - i);
    resto = (soma * 10) % 11;
    if (resto === 10 || resto === 11) resto = 0;
    if (resto !== parseInt(cpf.substring(9, 10))) return false;

    soma = 0;
    for (let i = 1; i <= 10; i++) soma += parseInt(cpf.substring(i-1, i)) * (12 - i);
    resto = (soma * 10) % 11;
    if (resto === 10 || resto === 11) resto = 0;
    if (resto !== parseInt(cpf.substring(10, 11))) return false;

    return true;
}

// Função para exibir mensagem de erro
function displayError(elementId, message) {
    const errorElement = document.getElementById(elementId);
    errorElement.textContent = message;
}

// Função para limpar todas as mensagens de erro
function clearErrors() {
    const errorMessages = document.querySelectorAll(".error-message");
    errorMessages.forEach(function (element) {
        element.textContent = "";
    });
}

// Função para aplicar máscara ao campo de celular enquanto o usuário digita
document.getElementById("number").addEventListener("input", function (event) {
    let input = event.target.value;

    // Remover tudo que não for número
    input = input.replace(/\D/g, '');

    // Adicionar a máscara (xx) xxxx-xxxx ou (xx) xxxxx-xxxx
    if (input.length > 10) {
        input = input.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
    } else if (input.length > 6) {
        input = input.replace(/(\d{2})(\d{4})(\d{0,4})/, '($1) $2-$3');
    } else if (input.length > 2) {
        input = input.replace(/(\d{2})(\d{0,5})/, '($1) $2');
    } else {
        input = input.replace(/(\d*)/, '($1');
    }

    // Atualizar o valor do campo
    event.target.value = input;
});

// Função para abrir a câmera
function openCamera() {
    navigator.mediaDevices.getUserMedia({ video: true })
        .then(function(stream) {
            const video = document.createElement('video');
            video.srcObject = stream;
            video.play();

            // Exibir a visualização da câmera e capturar uma foto (simplificado)
            video.addEventListener('click', function() {
                const canvas = document.createElement('canvas');
                canvas.width = video.videoWidth;
                canvas.height = video.videoHeight;
                const context = canvas.getContext('2d');
                context.drawImage(video, 0, 0, canvas.width, canvas.height);
                const profilePhoto = document.getElementById('profilePhoto');
                profilePhoto.src = canvas.toDataURL('image/png'); // Atualiza a foto de perfil
                stream.getTracks().forEach(track => track.stop()); // Para a transmissão da câmera
            });
        })
        .catch(function(err) {
            console.error("Erro ao acessar a câmera: ", err);
        });
}
*/


  