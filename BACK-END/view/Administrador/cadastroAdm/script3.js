async function cadastraAdmin() {
    const nome = "Júlia";

    // Definindo e-mail e senha fixos
    const emailFixo = "juliabbrioli@gmail.com";
    const senhaFixa = "julia";

    // Utilizando os valores fixos
    fetch("/cadastra_admin", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            nome: nome,
            email: emailFixo, // Usando e-mail fixo
            senha: senhaFixa   // Usando senha fixa
        })
    })
    .then((resp) => resp.json())
    .then((dados) => {
        console.log(dados);
        if (dados.sucesso === false) {
            throw "Administrador não cadastrado.\nMotivo: " + dados.motivoErro.detail;
        }

        alert("Cadastro feito com sucesso!");
        open("login_adm", "_self");
    })
    .catch((erro) => {
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

        campos.forEach((campo) => {
            if (campo.value != "") {
                camposPreenchidos++;
            }
        });

        if (camposPreenchidos != campos.length) {
            alert("Favor preencher todos os campos!");
        }
        else if (senha.value != confirmaSenha.value) {
            alert("As senhas preenchidas não correspondem!");
        }
        else {
            cadastraAdmin();
        }
    });
});
