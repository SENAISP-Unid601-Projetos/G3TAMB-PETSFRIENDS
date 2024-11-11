const psql = require("./conector_sql");

async function getVeterinarios() {
    const conexao = psql.conectaBanco();
    const consulta = await conexao.query("SELECT * FROM VETERINARIO");
    conexao.end();
    return consulta.rows;
    let resposta;
    try {
        const consulta = await conexao.query("SELECTE * FROM VETERINARIO");
        resposta = {
            sucesso: true,
            conteudo: consulta.rows
        }
    }
    catch(erro) {
        resposta = {
            sucesso: false,
            motivoErro: erro
        }
    }
    conexao.end();
    return resposta;
}


async function getVeterinario(dados) {
    const conexao = psql.conectaBanco();
    let resposta;

    try{
        const consulta = await conexao.query(`
            SELECT * FROM VETERINARIO
            WHERE crmv = '${dados.crmv}' AND
            senha = '${dados.senha}'
            `); //Antes tava comparando email e senha, mas no front tá como crmv e senha. Troquei aqui
        resposta = {
            sucesso: true,
            conteudo: consulta.rows
        }
    }
    catch(erro) {
        resposta = {
            sucesso: false,
            motivoErro: erro
        }
    }
    conexao.end();
    return resposta;

}

async function insertVeterinario(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        consulta = await conexao.query(`
            INSERT INTO VETERINARIO (
                        NOME, 
                        CRMV, 
                        CPF, 
                        EMAIL, 
                        SENHA
                         )
                VALUES  ('${dados.nome}', 
                         '${dados.crmv}', 
                         '${dados.cpf}',
                         '${dados.email}',
                         '${dados.senha}'
                         );
        `);
        resposta = {sucesso: true, dados: consulta};
    }
    catch(erro) {
        console.log(erro);
        resposta = {sucesso: false, motivoErro: erro}
    }
    conexao.end();
    return resposta;
}


exports.insertVeterinario = insertVeterinario;
exports.getVeterinario = getVeterinario;