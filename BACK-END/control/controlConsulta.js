const consulta = require("../model/consultas");

async function geraTabelaConsultas(req, res) {
    const dados = req.body;
    const resposta = await consulta.getTabelaConsultas(dados);
    res.json(resposta);
}

exports.geraTabelaConsultas = geraTabelaConsultas;