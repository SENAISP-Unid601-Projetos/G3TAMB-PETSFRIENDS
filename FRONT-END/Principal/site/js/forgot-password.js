async function enviaEmailSenha() {
    const campoEmail = document.querySelector("#email");
    const email = campoEmail.value;
    alert(email);
    const obj = {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            email: email
        })
    }
    await fetch("/resetSenha", obj)
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        alert(dados);
        alert("Verifique sua caixa de entrada. Se você já estiver cadastrado, você receberá um email com a recuperação de senha!");
        open("/", "_self");
    })
    .catch( (erro) => {
        alert("Erro ao enviar email\nMotivo: " + erro);
    })
}

window.addEventListener("DOMContentLoaded", () => {
    const botaoEnvia = document.querySelector("#botaoEnvia");

    botaoEnvia.addEventListener("click", async () => {
        let camposVazios = 0;

        document.querySelectorAll("input:not([type='submit'])").forEach( (campo) => {
            if (campo.value == "") {
                camposVazios++;
            }
        })

        if (camposVazios > 0) {
            alert("Favor preencha todos os campos!");
        }
        else {
            enviaEmailSenha();
        }
    })
})