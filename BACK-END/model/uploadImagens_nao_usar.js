const multer = require("multer");
const path = require("path");

const armazena = multer.diskStorage({
    destination: (req, res, cb) => {
        cb(null, `${req.tipoImagem}`)
    },
    filename: (req, file, cb) =>{
        const nomeUnico = `${Date.now()}-${Math.round(Math.random() * 1E9)}`;
    }
})