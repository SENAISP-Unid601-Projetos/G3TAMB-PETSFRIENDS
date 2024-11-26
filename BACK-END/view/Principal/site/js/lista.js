async function geraTabelaVeterinario() {
    const veterinarios = document.querySelector("#tabelaVeterinario");

    await fetch("/consulta_vets")
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        for (let i = 0; i < dados.length; i++) {
            const linha = document.createElement("tr");
            const nome = document.createElement("td");
            const crmv = document.createElement("td");
            const email = document.createElement("td");
            nome.innerText = dados[i].nome;
            crmv.innerText = dados[i].crmv;
            email.innerText = dados[i].email;
            linha.append(nome, crmv, email);
            veterinarios.append(linha);
        }
    })
    .catch( (erro) => {
        alert("Erro:\n" + erro);
    })
}

window.addEventListener("DOMContentLoaded", async () => {
    await geraTabelaVeterinario();
});