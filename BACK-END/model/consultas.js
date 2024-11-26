const psql = require("./conector_sql");

async function getTabelaConsultas(dados) {
    const conexao = psql.conectaBanco();
    const resposta = {
        sucesso: true
    }
    try {
        const query = `
            SELECT 		C.NUMERO AS "CODIGO_CONSULTA",
			    V.NOME AS "VETERINARIO",
			    A.NOME AS "ANIMAL",
			    A.RACA AS "RACA",
			    C.DATA AS "DATA_CONSULTA",
			    C.HORARIO AS "HORARIO_CONSULTA",
			    C.PRONTUARIO AS "DESCRICAO",
			    C.STATUS AS "STATUS"
            FROM CONSULTA C
                INNER JOIN VETERINARIO V
	                ON C.FK_VETERINARIO_CRMV = V.CRMV
                INNER JOIN ANIMAIS A
	                ON C.FK_CODIGO_ANIMAL = A.CODIGO
                WHERE V.CRMV = '${dados.crmv}' AND
	                C.STATUS <> 'Cancelada'
	            ORDER BY C.HORARIO;`;
        const consulta = await conexao.query(query);
        resposta.retorno = consulta.rows;
    }
    catch(erro) {
        resposta.sucesso = false;
        resposta.retorno = erro;
    }
    console.log(resposta);
    conexao.end();
    return resposta;
}

exports.getTabelaConsultas = getTabelaConsultas;

//getTabelaConsultas({crmv: "MG-1234"});