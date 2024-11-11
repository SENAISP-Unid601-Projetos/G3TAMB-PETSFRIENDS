const veterinarios = require("../model/veterinario.js");

async function consultaVet(req, res) {
    const dados = req.body;
    const resposta = await veterinarios.getVeterinario(dados);
    res.json(resposta);
}

async function cadastraVet(req, res) {
    const dados = req.body;
    const resposta = await veterinarios.insertVeterinario(dados);
    res.json(resposta);
}

exports.consultaVet = consultaVet;
exports.cadastraVet = cadastraVet;