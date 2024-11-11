const denuncia = require("../model/denuncia");

async function cadastraDenuncia(dados) {
    const resultado = await denuncia.insertDenuncia(dados);
    return resultado;
}

exports.cadastraDenuncia = cadastraDenuncia;