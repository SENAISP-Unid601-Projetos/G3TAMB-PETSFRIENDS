window.addEventListener("DOMContentLoaded", () => {
    const urlParams = new URLSearchParams(window.location.search);
    const codigo = urlParams.get('codigo');
    if (codigo) {
        fetch(`/listaAnimal?codigo=${codigo}`, {
            method: "GET"
        })
        .then((resp) => {
            return resp.json();
        })
        .then((dados) => {
            document.getElementById("codigo").value = dados.conteudo[0].codigo;
            document.getElementById("nome").value = dados.conteudo[0].nome;
            document.getElementById("raca").value = dados.conteudo[0].raca;
            document.getElementById("idade").value = dados.conteudo[0].idade;
            document.getElementById("diagnostico").value = dados.conteudo[0].diagnostico;
            document.getElementById("status").value = dados.conteudo[0].status;
            document.getElementById("estado").value = dados.conteudo[0].estado_de_saude;

            if (dados.sucesso === false || dados.conteudo.length < 1) {
                throw new Error("Nenhum animal encontrado com os dados informados!");
            }

            console.log(dados.conteudo);
        })
        .catch(async (erro) => {
            console.error(erro); 
            await Swal.fire({
                title: erro.message || erro,
                icon: "error"
            });
        });
    }
});
function salvaAlteracoes(){
    fetch("/editaAnimal", {
        method:"POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: `
        {
            "codigo":"${document.getElementById("codigo").value}",
            "nome":"${document.getElementById("nome").value}",
            "raca":"${document.getElementById("raca").value}",
            "idade":"${document.getElementById("idade").value}",
            "diagnostico":"${document.getElementById("diagnostico").value}",
            "status":"${document.getElementById("status").value}",
            "estado_de_saude":"${document.getElementById("estado").value}"
        }
        ` 
    })
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        alert("Dados atualizados com sucesso!");
        open("/TelaAnimalAdm","_self");
    })
    .catch( async (erro) => {
        await Swal.fire({
            title: `${erro}`,
            icon: "error"
          });
    });
}