async function geraTabelaConsultas() {
    const crmv = JSON.parse(localStorage.getItem("dadosVeterinario")).crmv;
    const tabela = document.querySelector("#tabelaConsultas tbody");
    const JsonReq = {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            crmv: crmv
        })
    }
    await fetch("/consultas_vet", JsonReq)
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        for (let i = 0; i < dados.retorno.length; i++) {
            let linha = `<tr class="consulta">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Pendente</td>
                    <td>
                        <div class="buttons">
                            <button class="accept">Aceitar</button>
                            <button class="reject">Recusar</button>
                        </div>
                    </td>
                </tr>`;
        }
    })
    .catch( (erro) => {
        alert(erro);
    })
}

window.addEventListener("DOMContentLoaded", async () => {
    await geraTabelaConsultas();
})