window.addEventListener("DOMContentLoaded", () => {
    fetch("/listaAnimaisDisponiveis", {
        method:"GET"})
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        dados.conteudo.forEach((animal) => {
            let html_animais = `<div class="col-md-4">
                                    <div class="team-minimal">
                                        <figure style="height: 200px;">
                                            <img src="../..${animal.img}" alt="${animal.img}" height="100%" style="border-radius:25px;" />
                                        </figure>
                                        <div class="team-minimal-caption">
                                            <p><strong>Nome:</strong> ${animal.nome}</p>
                                            <p><strong>Idade:</strong> ${animal.idade}</p>
                                            <p><strong>Raça:</strong> ${animal.raca}</p>
                                            <p><strong>Diagnóstico:</strong> ${animal.diagnostico}</p>
                                            <p><strong>Sexo:</strong> </p>
                                            <p><strong>Status:</strong> ${animal.status}</p>
                                            <p><strong>Estado de saúde:</strong> ${animal.estado_de_saude}</p>
                                            <div class="button-container">
                                                <button class="btn-adopt" onclick="adotaAnimal(${animal.codigo})">Adotar</button>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>`;
        document.querySelector("#row").innerHTML+=html_animais;
        });
    })
    .catch( (erro) => {
        alert(erro);
    });    
});

function adotaAnimal(codigo){
    const dados = {
        usuario: JSON.parse(localStorage.getItem("dadosUsuario")).cpf,
        codigo: codigo
    };
    Swal.fire({
        title: "Você está prestes a adotar! Deseja continuar?",
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: "Sim! 🐶",
        denyButtonText: `Não`
      }).then((result) => {
        if (result.isConfirmed) {
            fetch("/adotaAnimal", {
                method:"POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(dados)
            })
            .then( (resp) => {
                return resp.json();
            })
            .then( (dados) => {
                console.log(dados);
                if (dados.sucesso === false) {
                    throw "Erro ao adotar.\nMotivo: " + JSON.stringify(dados.motivoErro);
                }
                Swal.fire("Adoção realizada com sucesso! Por favor, envie os documentos necessários.", "", "success");
                open("/AdocaoAnimais", "_self");
            })
            .catch( (erro) => {
                alert(erro);
            });
        } else if (result.isDenied) {
          Swal.fire("Adoção Cancelada", "", "info");
        }
      });
}