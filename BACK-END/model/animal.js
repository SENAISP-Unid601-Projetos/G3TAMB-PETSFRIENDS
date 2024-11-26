const psql = require("./conector_sql");

async function getAnimais(dados) {
    const conexao = psql.conectaBanco();
    let resposta;

    try{
        const query = `SELECT * FROM ANIMAIS`
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

async function getAnimal(dados) {
    const conexao = psql.conectaBanco();
    let resposta;

    try{
        const query = `SELECT * FROM ANIMAIS WHERE CODIGO = ${dados.codigo}`;
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


async function getAnimaisDisponiveis() {
    const conexao = psql.conectaBanco();
    let resposta;

    try{
        const query = `SELECT * FROM ANIMAIS WHERE STATUS = 'disponivel'`;
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

async function getAnimaisAdotados() {
    const conexao = psql.conectaBanco();
    let resposta;

    try{
        const query = `SELECT * FROM ANIMAIS WHERE STATUS = 'adotado'`;
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
    conexao.end();
    return resposta;
}

async function postExcluiAnimal(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        consulta = await conexao.query(`
            DELETE FROM ANIMAIS
            WHERE  CODIGO = ${dados.codigo}
        `);
        resposta = {sucesso: true, dados: consulta};
    }
    catch(erro) {
        resposta = {sucesso: false, motivoErro: erro}
    }
    conexao.end();
    return resposta;
}

async function postEditaAnimal(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
        consulta = await conexao.query(`
            UPDATE  ANIMAIS
            SET     NOME = '${dados.nome}',
                    RACA = '${dados.raca}',
                    DIAGNOSTICO = '${dados.diagnostico}',
                    IDADE = ${dados.idade},
                    STATUS = '${dados.status}',
                    ESTADO_DE_SAUDE = '${dados.estado_de_saude}'
            WHERE   CODIGO = ${dados.codigo}
        `);
        resposta = {sucesso: true, dados: consulta};
    }
    catch(erro) {
        resposta = {sucesso: false, motivoErro: erro}
    }
    conexao.end();
    return resposta;
}

async function postAdotaAnimal(dados) {
    const conexao = psql.conectaBanco();
    let resposta;
    try {
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
    conexao.end();
    return resposta;
}

exports.getAnimais = getAnimais;
exports.getAnimal = getAnimal;
exports.postAnimal = postAnimal;
exports.getAnimaisDisponiveis = getAnimaisDisponiveis;
exports.getAnimaisAdotados = getAnimaisAdotados;
exports.postAdotaAnimal = postAdotaAnimal;
exports.postExcluiAnimal = postExcluiAnimal;
exports.postEditaAnimal = postEditaAnimal;