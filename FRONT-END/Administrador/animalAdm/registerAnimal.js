async function cadastraAnimal() {
    const dadosForm = new FormData();
    const nome = document.querySelector("#nome");
    const idade = document.querySelector("#idade");
    const raca = document.querySelector("#raca");
    const diagnostico = document.querySelector("#diagnostico");
    
    const status = document.querySelector("#status");
    const estado_saude = document.querySelector("#estado_saude");
    const foto = document.querySelector("#foto").files[0];
    dadosForm.append("imagem", foto);
    dadosForm.append("nome", nome.value);
    dadosForm.append("idade", idade.value);
    dadosForm.append("raca", raca.value);
    dadosForm.append("diagnostico", diagnostico.value);
    
    dadosForm.append("status", status.value);
    dadosForm.append("estado_saude", estado_saude.value);
    dadosForm.append("email", localStorage.getItem("emailAdm"));

    /*
        body: JSON.stringify({
            nome: nome.value,
            idade: idade.value,
            raca: raca.value,
            diagnostico: diagnostico.value,
            sexo: sexo.value,
            status: status.value,
            estado_saude: estado_saude.value,
            foto: foto.files[0],
            email: localStorage.getItem("emailAdm")
        })*/

    fetch("/cadastra_animal", {
        method:"POST",
        body: dadosForm
    })
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        console.log(dados);
        if (dados.sucesso === false) {
            throw "Usuário não cadastrado.\nMotivo: " + JSON.stringify(dados.motivoErro);
        }
        alert("Cadastro feito com sucesso!");
        open("/TelaAnimalAdm", "_self");
    })
    .catch( (erro) => {
        alert(erro);
    });
}

window.addEventListener("DOMContentLoaded", () => {
    const botaoEnvia = document.querySelector("body > div > div.form > form > div.continue-button > button");
    
    botaoEnvia.addEventListener("click", () => {
        const campos = document.querySelectorAll("input[required]");
        let camposPreenchidos = 0;

        campos.forEach( (campo) => {
            if (campo.value != "") {
                camposPreenchidos++;
            }
        })

        if (camposPreenchidos === campos.length) {
            cadastraAnimal();
        }
        else {
            alert("Favor preencher todos os campos!");
        }
    })
})
