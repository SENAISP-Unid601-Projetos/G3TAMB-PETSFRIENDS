const psql = require("./conector_sql");

async function getAdmin(dados) {
    const conexao = psql.conectaBanco();
    console.log(dados);
    let resposta;

    try{
        const query = `SELECT * FROM ADMINISTRADOR
        WHERE email = '${dados.email}' AND
        senha = '${dados.senha}'
        `
        console.log(query);
        const consulta = await conexao.query(query);
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
    console.log(resposta);
    conexao.end();
    return resposta;
}

async function insertAdmin(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        consulta = await conexao.query(`
            INSERT INTO ADMINISTRADOR (NOME, 
                         EMAIL, 
                         SENHA)
                VALUES  ('${dados.nome}', 
                         '${dados.email}', 
                         '${dados.senha}');
        `);
        resposta = {sucesso: true, dados: consulta};
    }
    catch(erro) {
        resposta = {sucesso: false, motivoErro: erro}
    }
    console.log(resposta);
    conexao.end();
    return resposta;
}

exports.getAdmin = getAdmin;
exports.insertAdmin = insertAdmin;

