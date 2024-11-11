const multer = require("multer");
const path = require("path");

const armazenamentoDenuncia = multer.diskStorage( {
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, `/assets/imgs_denuncia`))
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`)
    }
} )

const armazenamentoPerfil = multer.diskStorage( {
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, `/assets/imgs_perfil`))
    },
    filename: (req, file, cb) => {
        cb(null, `${file.originalname}-${Date.now()}`)
    }
} )

exports.armazenamentoDenuncia = armazenamentoDenuncia;
exports.armazenamentoPerfil = armazenamentoPerfil;