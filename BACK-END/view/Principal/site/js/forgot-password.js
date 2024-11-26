async function enviaEmailSenha() {
    const campoEmail = document.querySelector("#email");
    const email = campoEmail.value;
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
    .then( async (dados) => {
        await Swal.fire({
            title: "Informação",
            text: `Verifique sua caixa de entrada. Se você já estiver cadastrado, você receberá um email com a recuperação de senha!`,
            icon: "info",
            timer: 2000,
            timerProgressBar: true
        });
        open("/", "_self");
    })
    .catch( async (erro) => {
        await Swal.fire({
            title: "Erro ao enviar email!",
            text: `${erro}`,
            icon: "error",
            timer: 2000,
            timerProgressBar: true
          });
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
            await Swal.fire({
                title: "Erro",
                text: "Favor preencha todos os campos!",
                icon: "error",
                timer: 2000,
                timerProgressBar: true
              });
        }
        else {
            enviaEmailSenha();
        }
    })
})