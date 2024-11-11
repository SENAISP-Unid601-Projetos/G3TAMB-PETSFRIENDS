const psql = require("./conector_sql");

async function getAnimais(dados) {
    const conexao = psql.conectaBanco();
    console.log(dados);
    let resposta;

    try{
        const query = `SELECT * FROM ANIMAIS`
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

async function getAnimaisDisponiveis() {
    const conexao = psql.conectaBanco();
    let resposta;

    try{
        const query = `SELECT * FROM ANIMAIS WHERE STATUS = 'disponivel'`
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

async function getAnimaisAdotados() {
    const conexao = psql.conectaBanco();
    let resposta;

    try{
        const query = `SELECT * FROM ANIMAIS WHERE STATUS = 'adotado'`
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

async function postAnimal(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        consulta = await conexao.query(`
            INSERT INTO ANIMAIS (   DIAGNOSTICO, 
                                    NOME, 
                                    RACA, 
                                    IDADE,
                                    STATUS,
                                    ESTADO_DE_SAUDE,
                                    FK_EMAIL_ADMINISTRADOR,
                                    IMG
                                )
                VALUES          (   '${dados.diagnostico}', 
                                    '${dados.nome}', 
                                    '${dados.raca}',
                                    '${dados.idade}',
                                    '${dados.status}',
                                    '${dados.estado_saude}',
                                    '${dados.email}',
                                    '${dados.foto}'
                                    );
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

async function postAdotaAnimal(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        console.log(`
            UPDATE	ANIMAIS
            SET		STATUS = 'adotado',
                    FK_CPF_USUARIO = '${dados.usuario}'
            WHERE	CODIGO = ${dados.codigo};
        `);
        consulta = await conexao.query(`
            UPDATE	ANIMAIS
            SET		STATUS = 'adotado',
                    FK_CPF_USUARIO = '${dados.usuario}'
            WHERE	CODIGO = ${dados.codigo};
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

exports.getAnimais = getAnimais;
exports.postAnimal = postAnimal;
exports.getAnimaisDisponiveis = getAnimaisDisponiveis;
exports.getAnimaisAdotados = getAnimaisAdotados;
exports.postAdotaAnimal = postAdotaAnimal;;