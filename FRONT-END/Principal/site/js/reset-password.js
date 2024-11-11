async function atualizaSenha() {
    const campoSenha = document.querySelector("#new-password");
    const email = JSON.parse(atob(window.location.href.split("?id=")[1]));
    email.novaSenha = campoSenha.value;
    alert(email);
    const obj = {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(email)
    }
    await fetch("/updateSenha", obj)
    .then( (resp) => {
        if (resp.status >= 400) {
            throw `Não foi possível atualizar o email\nMotivo: ${JSON.stringify(resp.json())}`;
        }
        return resp.json();
    })
    .then( (dados) => {
        alert("Senha atualizada com sucesso!");
        open("/", "_self");
    })
    .catch( (erro) => {
        alert(erro);
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
            atualizaSenha();
        }
    })
})