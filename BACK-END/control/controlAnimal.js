const animal = require("../model/animal.js");
const multer = require("multer");
const path = require("path");

const storageAdocao = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, "../assets/imgs_adocao"));
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const uploadImgAdocao = multer({ storage: storageAdocao });

async function consultaTodosAnimais(req, res) {
    const resposta = await animal.getAnimais();
    res.json(resposta);
}

async function consultaAnimal(req, res) {
    const resposta = await animal.getAnimal(req.query);
    res.json(resposta);
}

async function consultaAnimaisDisponiveis(req, res) {
    const resposta = await animal.getAnimaisDisponiveis();
    res.json(resposta);
}

async function consultaAnimaisAdotados(req, res) {
    const resposta = await animal.getAnimaisAdotados();
    res.json(resposta);
}

async function cadastraAnimal(req, res) {
    if (!req.file) {
        req.body.foto = null;
    }
    req.body.foto = "/assets/imgs_adocao/" + req.file.filename;
    const resposta = await animal.postAnimal(req.body);
    res.json(resposta);
}

async function adotaAnimal(req, res) {
    const resposta = await animal.postAdotaAnimal(req.body);
    res.json(resposta);
}

async function excluirAnimal(req, res) {
    const resposta = await animal.postExcluiAnimal(req.body);
    res.json(resposta);
}

async function editarAnimal(req, res) {
    const resposta = await animal.postEditaAnimal(req.body);
    res.json(resposta);
}

exports.consultaTodosAnimais = consultaTodosAnimais;
exports.consultaAnimal = consultaAnimal;
exports.cadastraAnimal = cadastraAnimal;
exports.uploadImgAdocao = uploadImgAdocao;
exports.consultaAnimaisDisponiveis = consultaAnimaisDisponiveis;
exports.consultaAnimaisAdotados = consultaAnimaisAdotados;
exports.adotaAnimal = adotaAnimal;
exports.excluirAnimal = excluirAnimal;
exports.editarAnimal = editarAnimal;