const psql = require("./conector_sql");

async function insertDenuncia(dados) {
    const agora = new Date();
    const dataFormatada = `${agora.getFullYear()}-${agora.getMonth()+1}-${agora.getDate()} ${agora.getHours()}:${agora.getMinutes()}:${agora.getSeconds()}`;
    const conexao = psql.conectaBanco();
    const resposta = {};
    try {
      const query = `
      INSERT INTO ABANDONO (DESCRICAO, FOTO, DATA_ABANDONO,
					 LUGAR, STATUS_ADM, NOME_DENUNCIANTE,
					 TELEFONE_DENUNCIANTE, EMAIL_DENUNCIANTE)
VALUES ('${dados.descricao}', '${dados.foto}', '${dataFormatada}',
	   '${dados.endereco + " - " + dados.cep}', 'Criado', '${
        dados.nome == "" ? "Anônimo":dados.nome}', 
        '${dados.telefone}', '${dados.email}');
      `;
      const consulta = await conexao.query(query);
      resposta.sucesso = true;
      resposta.mensagem = consulta;  
    }
    catch(erro) {
        resposta.sucesso = false;
        resposta.motivo = erro;
    }
    conexao.end();
    return resposta;
}

/*
{
    "descricao": "Achei um doguinho",
    "foto": "/assets/imgs_denuncia/1730803876375-conflitos.png",
    "endereco": "Ribeirão Preto - SP",
    "cep": "14057040",
    "nome": "",
    "telefone": "(16)3639-2396",
    "email": "teste.petfriends@hotmail.com"
}
    */

exports.insertDenuncia = insertDenuncia;