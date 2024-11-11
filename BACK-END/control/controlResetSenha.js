const resetSenha = require("../model/resetSenha.js");


function enviaResetSenha(req, res) {
    const dados = req.body;
    const resposta = resetSenha.enviarResetSenha(dados);
    res.json({});
}

async function atualizaSenha(req, res) {
    const dados = req.body;
    const resposta = await resetSenha.atualizarSenha(dados);
    res.status(resposta.sucesso === true ? 200:500).json(resposta);
}

exports.enviaResetSenha = enviaResetSenha;
exports.atualizaSenha = atualizaSenha;