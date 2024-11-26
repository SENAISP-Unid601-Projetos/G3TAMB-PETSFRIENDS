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
                                            <p><strong>Status:</strong> ${animal.status}</p>
                                            <p><strong>Estado de saúde:</strong> ${animal.estado_de_saude}</p>
                                            <div class="button-container">
                                                <button class="btn-adopt" onclick="editarAnimal(${animal.codigo})">Editar</button>
                                                <button class="btn-adopt-exclui" onclick="excluirAnimal(${animal.codigo})">Excluir</button>
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

    fetch("/listaAnimaisAdotados", {
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
                                            <p><strong>Status:</strong> ${animal.status}</p>
                                            <p><strong>Estado de saúde:</strong> ${animal.estado_de_saude}</p>
                                            <div class="button-container">
                                                <button class="btn-adopt" onclick="editarAnimal(${animal.codigo})">Editar</button>
                                                <button class="btn-adopt-exclui" onclick="excluirAnimal(${animal.codigo})">Excluir</button>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>`;
        document.querySelector("#row-adotados").innerHTML+=html_animais;
        });
    })
    .catch( (erro) => {
        alert(erro);
    });  
});

function excluirAnimal(codigo){
    const jsonData = {"codigo": codigo};
   fetch("/excluiAnimal", {
        method:"POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(jsonData)
    })
    .then( (resp) => {
        return resp.json();
    })
    .then( (dados) => {
        console.log(dados);
        if (dados.sucesso === false) {
            throw "Animal não excluído.\nMotivo: " + JSON.stringify(dados.motivoErro);
        }
        alert("Animal Excluído com sucesso!");
        open("/TelaAnimalAdm", "_self");
    })
    .catch( (erro) => {
        alert(erro);
    });
}
function editarAnimal(codigo){
    localStorage.setItem("codigo", codigo);
    open("/edita_animal?codigo="+codigo, "_self");
}