async function loginAdmin() {
    localStorage.removeItem("dadosUsuario");

    // Definindo e-mail e senha fixos
    const emailFixo = document.querySelector("#email").value;
    localStorage.setItem("emailAdm",emailFixo);
    const senhaFixa = document.querySelector("#password").value;

    // Usando os valores fixos
    await fetch("/pega_admin", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            email: emailFixo, // Usando e-mail fixo
            senha: senhaFixa   // Usando senha fixa
        })
    })
    .then((resp) => {
        return resp.json();
    })
    .then((dados) => {
        if (dados.sucesso === false || dados.conteudo.length < 1) {
            throw "Nenhum usuário foi encontrado com os dados inseridos!";
        }
        const tratado = dados.conteudo[0];
        localStorage.setItem("dadosUsuario", JSON.stringify(tratado));
        open("/TelaAnimalAdm", "_self");
    })
    .catch((erro) => {
        alert(erro);
    });
}

window.addEventListener("DOMContentLoaded", () => {
    const botaoEnvia = document.querySelector("#botaoEnvia");
    
    botaoEnvia.addEventListener("click", () => {
        // Como estamos usando valores fixos, não precisamos verificar a entrada
        loginAdmin();
    });
});
