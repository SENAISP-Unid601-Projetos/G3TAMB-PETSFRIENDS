const administrador = require("../model/administrador");

async function consultaAdmin(req, res) {
    const dados = req.body;
    const resposta = await administrador.getAdmin(dados);
    res.json(resposta);
}

async function cadastraAdmin(req, res) {
    const resposta = await administrador.insertAdmin(req.body);
    res.json(resposta);
}

exports.consultaAdmin = consultaAdmin;
exports.cadastraAdmin = cadastraAdmin;