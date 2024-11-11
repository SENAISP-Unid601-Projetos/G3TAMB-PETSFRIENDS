const email = require("./email");
const psql = require("./conector_sql");
const os = require("os");

function pegaIPAtual() {
    const ipsDisponiveis = os.networkInterfaces()["Wi-Fi"];
    let ip;

    for (i in ipsDisponiveis) {
        if (ipsDisponiveis[i].address.match("10.141.129") != null) {
            ip = ipsDisponiveis[i].address;
            break;
        }
    }
    return ip;
}

async function enviarResetSenha(dados) {
    const conexao = psql.conectaBanco();
    try {
        const myIp = pegaIPAtual();
        const consulta = await conexao.query(`SELECT * FROM (SELECT NOME, EMAIL, SENHA, 'USUARIO' as TIPO_USUARIO 
            FROM USUARIO UNION (SELECT NOME, EMAIL, SENHA, 'VETERINARIO' as TIPO_USUARIO FROM VETERINARIO)
            UNION (SELECT NOME, EMAIL, SENHA, 'ADMINISTRADOR' as TIPO_USUARIO FROM ADMINISTRADOR))
            WHERE EMAIL = '${dados.email}';`);
        if (consulta.rows.length < 1) {
            throw "Nenhum usuário encontrado!";
        }
        
        const destinatario = `{"email": "${dados.email}", "tipoUsuario": "${consulta.rows[0].tipo_usuario}"}`;
        const identificador = new Buffer(destinatario).toString("base64");
        const assunto = "Solicitação para Definição de Nova Senha";
        const corpo = `
        <p>Olá!</p>
        <p>Clique <a href="http://${myIp}:8080/resetSenha?id=${identificador}">neste link</a> para reiniciar sua senha!</p>
        `;
        email.enviaEmail(destinatario, assunto, corpo);
    }
    catch (erro) {
        console.log(erro);
    }
    conexao.end();
}

async function atualizarSenha(dados) {
    const conexao = psql.conectaBanco();
    console.log(dados);
    resultado = {sucesso: true};
    try {
        const consulta = await conexao.query(`UPDATE ${dados.tipoUsuario}
        SET senha = '${dados.novaSenha}' WHERE
        email = '${dados.email}'`);
        resultado.conteudo = consulta;
    }
    catch(erro) {
        resultado.sucesso = false;
        resultado.motivoErro = `${erro}`;
    }
    conexao.end();
    return resultado;
}

exports.enviarResetSenha = enviarResetSenha;
exports.atualizarSenha = atualizarSenha;