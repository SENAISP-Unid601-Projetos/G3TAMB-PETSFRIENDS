async function testeFoto() {
    const campoFoto = document.querySelector("#contact-photo");
    const dadosForm = new FormData();
    const foto = campoFoto.files[0];    
    dadosForm.append("imagem", foto);
    dadosForm.append("tipoImagem", "imgs_denuncia");
    dadosForm.append("descricao", document.querySelector("#contact-message").value) ;
    dadosForm.append("endereco", document.querySelector("#contact-address").value);
    dadosForm.append("cep", document.querySelector("#contact-cep").value);
    dadosForm.append("nome", document.querySelector("#contact-full-name").value);
    dadosForm.append("telefone", document.querySelector("#contact-phone").value);
    dadosForm.append("email", document.querySelector("#contact-email").value);
    await fetch("/denunciar", {
        method: "POST",
        body: dadosForm
    })
    .then( (resp) => {
        return resp.json();
    })
    .then( (resp) => {
        console.log(resp);
        alert("Denuncia feita com sucesso!");
        window.location.reload();
    })
    .catch( (erro) => {
        alert(erro);
    })
}

window.addEventListener("DOMContentLoaded", () => {
    
    const botaoEnvia = document.querySelector("button[type='submit']");

    botaoEnvia.addEventListener("click", async (e) => {
        //await testeFoto(e.target);
        const camposObrigatorios = document.querySelectorAll("[data-constraints*=\"@Required\"]");
    let camposVazios = camposObrigatorios.length;

    camposObrigatorios.forEach( (campo) => {
        if (campo.value != "") {
            camposVazios--;
        }
    })

    if (camposVazios > 0) {
        alert("Favor preencher todos os campos obrigatórios!");
    }
    else {
        testeFoto();
    }
    })
})