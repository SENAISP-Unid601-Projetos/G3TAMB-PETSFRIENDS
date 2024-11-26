const psql = require("./conector_sql");

async function getClientes() {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        const consulta = await conexao.query("SELECT * FROM USUARIO");
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

async function getCliente(dados) {
    const conexao = psql.conectaBanco();
    console.log(dados);
    let resposta;

    try{
        const query = `SELECT * FROM USUARIO
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
    conexao.end();
    return resposta;
}

async function insertClientes(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        consulta = await conexao.query(`
            INSERT INTO USUARIO (CPF, 
                         NOME, 
                         DATA_DE_NASCIMENTO, 
                         TELEFONE, 
                         SENHA, 
                         EMAIL,
                         FOTO)
                VALUES  ('${dados.cpf}', 
                         '${dados.nome}', 
                         '${dados.dataNascimento}',
                         '${dados.telefone}',
                         '${dados.senha}',
                         '${dados.email}',
                         '${dados.foto}');
        `);
        resposta = {sucesso: true, dados: consulta};
    }
    catch(erro) {
        resposta = {sucesso: false, motivoErro: erro}
    }
    conexao.end();
    return resposta;
}

async function updateClientes(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        consulta = await conexao.query(`
            UPDATE  USUARIO  
            SET     CPF = '${dados.cpf}',
                    NOME = '${dados.nome}', 
                    DATA_DE_NASCIMENTO = '${dados.dataNascimento}',
                    TELEFONE = '${dados.telefone}',
                    EMAIL = '${dados.email}',
                    FOTO = '${dados.foto}'
            WHERE CPF = '${dados.cpf}';
        `);
        resposta = {sucesso: true, dados: consulta};
    }
    catch(erro) {
        resposta = {sucesso: false, motivoErro: erro}
    }
    conexao.end();
    return resposta;
}

async function deleteClientes(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        consulta = await conexao.query(`
            DELETE FROM usuario 
            WHERE CPF = '${dados.cpf}';
        `);
        resposta = {sucesso: true, dados: consulta};
    }
    catch(erro) {
        resposta = {sucesso: false, motivoErro: erro}
    }
    conexao.end();
    return resposta;
}

exports.getClientes = getClientes;
exports.insertClientes = insertClientes;
exports.getCliente = getCliente;
exports.updateClientes = updateClientes;
exports.deleteClientes = deleteClientes;
/*
async function getCliente(filtros) {
    const conexao = psql.conectaBanco();
    let strConsulta = `SELECT * FROM lugaluga.cliente WHERE`;

    //Inserindo filtros especificados na requisição.
    for (let i in filtros) {
        strConsulta = `${strConsulta} ${i} = '${filtros[i]}' AND`;
    }
    //As próximas linhas vão tirar o " AND" extra, a fim de corrigir a query
    const ultimoAnd = strConsulta.lastIndexOf(" AND")
    strConsulta = `${strConsulta.substring0(ultimoAnd,0)} LIMIT 1`;
    //Correção feita! :)
    const consulta = await conexao.query(strConsulta);
    conexao.end();
    return consulta["rows"];
}

async function insertCliente(dados) {
    const conexao = psql.conectaBanco();
    const resposta = {};
    try {
        const cadastro = await conexao.query(`
        INSERT INTO lugaluga.cliente (nome, cpf, email, celular, senha)
        VALUES ('${dados.nome}', '${dados.cpf}', '${dados.email}', 
        '${dados["celular"]}', '${dados["senha"]}');
        `);
        //Não precisa de throw aqui, pois, no caso do insert
        //Qualquer problema na query vai para o catch.
        resposta.sucesso = true;
        resposta.resultado = cadastro;
    }
    catch(erro) {
        resposta.sucesso = false;
        resposta.motivoErro = erro;
    }
    conexao.end();
    return resposta;
}

async function updateCliente(dados) {
    const conexao = psql.conectaBanco();
    let strConsulta = `UPDATE lugaluga.cliente SET`;

    for (let i in dados) {

        if (i != "cpf") { //Só vai inserir valores novos em campos que não for CPF (afinal, CPF não muda)
            strConsulta = `${strConsulta} ${i} = '${dados[i]}', `;
        }
    }
    const ultimaVirgula = strConsulta.lastIndexOf(", ")
    strConsulta = `${strConsulta.substring(ultimaVirgula,0)} WHERE cpf='${dados['cpf']}'`;
    console.log(strConsulta);
    const resposta = await conexao.query(strConsulta);
    conexao.end();
    return resposta;
}

/*
Lembrando que o nome depois de "exports." é um "apelido" para as funções criadas.
Quando importarmos este arquivo, ao invés de escrever getClientes, vamos escrever
pegaUsuarios, por exemplo
*/
//exports.pegaUsuarios = getClientes;
/*
exports.pegaUsuario = getCliente;
exports.cadastraUsuario = insertCliente;
exports.atualizaUsuario = updateCliente;*/