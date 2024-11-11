const imagem = require("../model/uploadImagem_nao_usar.js");

function uploadImagemDenuncia(req, res) {
    if (req.file) {
        res.status(201).send(`Imagem carregada com sucesso em ${req.file.path}`);
    }
    else {
        res.status(400).send(`Erro ao fazer upload da imagem!`);
    }
}

function uploadImagemPerfil(req, res) {
    if (req.file) {
        res.status(201).send(`Imagem carregada com sucesso em ${req.file.path}`);
    }
    else {
        res.status(400).send(`Erro ao fazer upload da imagem!`);
    }
}

exports.uploadImagemDenuncia = uploadImagemDenuncia;
exports.uploadImagemPerfil = uploadImagemPerfil;