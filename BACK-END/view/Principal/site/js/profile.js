function preencheDados() {
    const dados = JSON.parse(localStorage.getItem("dadosUsuario"));
    const campoNome = document.querySelector("#fullName");
    const campoEmail = document.querySelector("#email");
    const campoCpf = document.querySelector("#cpf");
    const campoDataNascimento = document.querySelector("#dob");
    const campoTelefone = document.querySelector("#phone");
    const dataNascimento = new Date(dados.data_de_nascimento);
    console.log(dataNascimento);
    const strData = dataNascimento.getUTCFullYear() + "-" + (dataNascimento.getUTCMonth()+1 < 10 ? `0${dataNascimento.getUTCMonth()+1}`:dataNascimento.getUTCMonth()+1) + "-" + (dataNascimento.getUTCDate() < 10 ? `0${dataNascimento.getUTCDate()}`:dataNascimento.getUTCDate());
    const fotoPerfil = document.querySelector("#profilePhoto");
    campoNome.value = dados.nome;
    campoEmail.value = dados.email;
    campoCpf.value = dados.cpf;
    campoDataNascimento.value = strData;
    campoTelefone.value = dados.telefone;

    if (dados.foto != "null" && dados.foto != null) {
        fotoPerfil.setAttribute("src", dados.foto);
    }
}

function uploadImagem() {
    const botaoUpload = document.querySelector("#new-profile-photo");
    const dados = new FormData();
    dados.append("imagem", botaoUpload.files[0]);

    fetch("uploadImagemPerfil", {
        method:"POST",
        body: dados
    })
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        const fotoPerfil = document.querySelector(".profile-photo img");
        nomeFotoPerfil = `/assets/imgs_perfil/${dados.filename}`;
        fotoPerfil.setAttribute("src", nomeFotoPerfil);
        console.log(dados);
    })
    .catch( (erro) => {
        nomeFotoPerfil = "";
        console.error(erro);
    })
}

function habilitaCampo(campo) {
    const idCampo = campo.getAttribute("data-field");
    const campoEscolhido = document.querySelector("#" + idCampo);
    campoEscolhido.disabled = campoEscolhido.disabled === true ? false:true;
    console.log(campoEscolhido.disabled);
}

async function atualizaCliente() {
    const campoNome = document.querySelector("#fullName");
    const campoEmail = document.querySelector("#email");
    const campoCpf = document.querySelector("#cpf");
    const campoDataNascimento = document.querySelector("#dob");
    const campoTelefone = document.querySelector("#phone");
    const fotoPerfil = document.querySelector("#profilePhoto");
    const bodyReq = {
        nome: campoNome.value,
        dataNascimento: campoDataNascimento.value,
        telefone: campoTelefone.value,
        email: campoEmail.value,
        foto: fotoPerfil.getAttribute("src"),
        cpf: campoCpf.value
    }
    const jsonReq = {
        method:"POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(bodyReq)
    }

    await fetch("/atualiza_usuario", jsonReq)
    .then( (resp) => {
        return resp.json();
    })
    .then( async (dados) => {
        bodyReq.data_de_nascimento = bodyReq.dataNascimento;
        delete bodyReq.dataNascimento;
        localStorage.setItem("dadosUsuario", JSON.stringify(bodyReq));
        await Swal.fire({
            title: "Usuário atualizado com sucesso!",
            icon: "success",
            timer: 2000,
            timerProgressBar: true
          });
        open("perfil", "_self");
    })
    .catch( async (erro) => {
        await Swal.fire({
            title: `${erro}`,
            icon: "error",
            timer: 2000,
            timerProgressBar: true
          });
    })
}

async function excluiCadastro() {
    const dados = localStorage.getItem("dadosUsuario");
    const jsonReq = {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: dados
    }
    await fetch("/descadastrar_usuario", jsonReq)
    .then( (resp) => {
        return resp.json();
    })
    .then( async (dados) => {
        localStorage.clear();
        await Swal.fire({
            title: `Usuário excluído com sucesso!`,
            icon: "success",
            timer: 2000,
            timerProgressBar: true
          });
        open("/", "_self");
    })
    .catch( async (erro) => {
        await Swal.fire({
            title: `${erro}`,
            icon: "error",
            timer: 2000,
            timerProgressBar: true
          });
    })
}

async function funcaoBotaoDelete() {
    await Swal.fire({
        title: `Atenção!`,
        text: "Esta operação é irreversível! Deseja prosseguir mesmo assim?",
        icon: "warning",
        confirmButtonText: "Sim",
        showDenyButton: true,
        denyButtonText: "Não"
      }).then( async (resposta) => {
        if (resposta.isConfirmed) {
            await excluiCadastro();
        }
      })
}

window.addEventListener("DOMContentLoaded", () => {
    preencheDados();

    const botaoUploadPerfil = document.querySelector("#new-profile-photo");

    botaoUploadPerfil.addEventListener("change", () => {
        uploadImagem();
    })
})