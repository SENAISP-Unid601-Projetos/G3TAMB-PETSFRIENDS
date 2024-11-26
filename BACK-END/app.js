const express = require("express");
const fs = require("fs");
const path = require("path");
const multer = require("multer");
const app = express();
const porta = 8080;

// Configuração de caminhos
const caminhoModel = path.join(__dirname, "model");
const caminhoView = path.join(__dirname, "view");
const caminhoController = path.join(__dirname, "controller");
const caminhoPrincipal = path.join(caminhoView, "Principal", "site");
const caminhoCadastroVeterinario = path.join(caminhoView, "Veterinario", "veterinario cadastro");
const caminhoGestaoVeterinario = path.join(caminhoView, "Veterinario", "veterinario gerenciar");
const caminhoLoginVeterinario = path.join(caminhoView, "Veterinario", "veterinario login");
const caminhoCadastroAdmin = path.join(caminhoView, "Administrador", "cadastroAdm");
const caminhoLoginAdmin = path.join(caminhoView, "Administrador", "loginAdm");
const caminhoAnimalAdmin = path.join(caminhoView, "Administrador", "animalAdm");

const clientes = require("./control/controlUsuarios.js");
const veterinarios = require("./control/controlVeterinario.js");
const administrador = require("./control/controlAdministrador.js");
const resetSenha = require("./control/controlResetSenha.js");
const animal = require("./control/controlAnimal.js");
const denuncia = require("./control/controlDenuncia.js");
const consulta = require("./control/controlConsulta.js");
//const uploadImagem = require("./control/controlUploadImagens_nao_usar.js");

// Configuração do multer para uploads de imagens
const storageDenuncia = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, "/assets/imgs_denuncia"));
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const uploadImgDenuncia = multer({ storage: storageDenuncia });

const storagePerfil = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, "/assets/imgs_perfil"));
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const uploadImgPerfil = multer({ storage: storagePerfil });
/*
const storageAdocao = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, "/assets/imgs_adocao"));
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const uploadImgAdocao = multer({ storage: storageAdocao });
*/
// Configurações do Express
app.use(express.static(caminhoModel));
app.use(express.static(caminhoView));
app.use(express.static(caminhoController));
app.use(express.static(caminhoPrincipal));
app.use(express.static(caminhoCadastroVeterinario));
app.use(express.static(caminhoLoginVeterinario));
app.use(express.static(caminhoGestaoVeterinario));
app.use(express.static(caminhoCadastroAdmin));
app.use(express.static(caminhoLoginAdmin));
app.use(express.static(caminhoAnimalAdmin));
app.use("/assets/imgs_denuncia", express.static(path.join(__dirname, "/assets/imgs_denuncia")));
app.use("/assets/imgs_perfil", express.static(path.join(__dirname, "/assets/imgs_perfil")));
app.use("/assets/imgs_adocao", express.static(path.join(__dirname, "/assets/imgs_adocao")));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// APIs dos Clientes
app.get("/clientes", clientes.consultaTodosClientes);
app.post("/login_usuario", clientes.consultaCliente);
app.post("/cadastra_usuario", clientes.cadastraCliente);
app.post("/atualiza_usuario", clientes.atualizaCliente);
app.post("/descadastrar_usuario", clientes.excluiCliente);

// APIs dos Veterinários
app.post("/pega_vet", veterinarios.consultaVet);
app.post("/cadastra_vet", veterinarios.cadastraVet);
app.get("/consulta_vets", veterinarios.consultaVets);
app.post("/consultas_vet", consulta.geraTabelaConsultas);

// APIs dos admins
app.post("/pega_admin", administrador.consultaAdmin);
app.post("/cadastra_admin", administrador.cadastraAdmin);

// APIs dos animais
app.post("/cadastra_animal", animal.uploadImgAdocao.single("imagem"), animal.cadastraAnimal);
app.get("/listaAnimal", animal.consultaAnimal);
app.get("/listaAnimaisDisponiveis", animal.consultaAnimaisDisponiveis);
app.get("/listaAnimaisAdotados", animal.consultaAnimaisAdotados);
app.post("/adotaAnimal", animal.adotaAnimal);
app.post("/excluiAnimal", animal.excluirAnimal);
app.post("/editaAnimal", animal.editarAnimal);

// API de reiniciar senha
app.post("/resetSenha", resetSenha.enviaResetSenha);
app.post("/updateSenha", resetSenha.atualizaSenha);

// Endpoints de upload de imagens
app.post("/denunciar", uploadImgDenuncia.single("imagem"), async (req, res) => {
    if (!req.file) {
        req.body.foto = null;
        //return res.status(400).send("{\"erro\": \"Nenhuma imagem foi enviada.\"}");
    }
    req.body.foto = "/assets/imgs_denuncia/" + req.file.filename;
    const cadastro = await denuncia.cadastraDenuncia(req.body);
    // Aqui você pode processar a imagem, como salvar informações no banco de dados
    res.status(cadastro.sucesso === true ? 201:500).json(cadastro);
});

app.post("/uploadImagemPerfil", uploadImgPerfil.single("imagem"), (req, res) => {
    if (!req.file) {
        return res.status(400).send("{\"erro\": \"Nenhuma imagem foi enviada.\"}");
    }
    // Aqui você pode processar a imagem, como salvar informações no banco de dados
    res.send(req.file);
});

// Páginas
app.get("/", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/index.html", "utf-8");
    res.send(pagina);
});

app.get("/sobre_nos", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/about.html", "utf-8");
    res.send(pagina);
});

app.get("/ajuda", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/typography.html", "utf-8");
    res.send(pagina);
});

app.get("/denunciar", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/contacts.html", "utf-8");
    res.send(pagina);
});

app.get("/login", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/login.html", "utf-8");
    res.send(pagina);
});

app.get("/perfil", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/profile.html", "utf-8");
    res.send(pagina);
});

app.get("/CadastrarAnimal", (req, res) => {
    const pagina = fs.readFileSync("./view/Administrador/animalAdm/animal-adm.html", "utf-8");
    res.send(pagina);
});

app.get("/LoginAdm", (req, res) => {
    const pagina = fs.readFileSync("./view/Administrador/loginAdm/login-adm.html", "utf-8");
    res.send(pagina);
});

app.get("/PainelAdm", (req, res) => {
    const pagina = fs.readFileSync("./view/Administrador/animalAdm/painel-adm.html", "utf-8");
    res.send(pagina);
});

app.get("/TelaAnimalAdm", (req, res) => {
    const pagina = fs.readFileSync("./view/Administrador/animalAdm/tela-animal.html", "utf-8");
    res.send(pagina);
});

app.get("/AdocaoAnimais", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/adocao.html", "utf-8");
    res.send(pagina);
});

app.get("/agendar_consulta", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/consulta.html", "utf-8");
    res.send(pagina);
});

app.get("/lista_veterinarios", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/lista.html", "utf-8");
    res.send(pagina);
});

app.get("/cadastro_usuario", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/register.html", "utf-8");
    res.send(pagina);
});

app.get("/esqueci_senha", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/forgot-password.html", "utf-8");
    res.send(pagina);
});

app.get("/resetSenha", (req, res) => {
    const pagina = fs.readFileSync("./view/Principal/site/reset-password.html", "utf-8");
    res.send(pagina);
});

app.get("/login_veterinario", (req, res) => {
    const pagina = fs.readFileSync("./view/Veterinario/veterinario login/index.html", "utf-8");
    res.send(pagina);
});

app.get("/cadastro_veterinario", (req, res) => {
    const pagina = fs.readFileSync("./view/Veterinario/veterinario cadastro/index.html", "utf-8");
    res.send(pagina);
});

app.get("/consultas_veterinario", (req, res) => {
    const pagina = fs.readFileSync("./view/Veterinario/veterinario gerenciar/consulta-vet.html", "utf-8");
    res.send(pagina);
});

app.get("/perfil_veterinario", (req, res) => {
    const pagina = fs.readFileSync("./view/Veterinario/veterinario gerenciar/perfil-vet.html", "utf-8");
    res.send(pagina);
});

app.get("/edita_animal", (req, res) => {
    const pagina = fs.readFileSync("./view/Administrador/animalAdm/editar-adm.html", "utf-8");
    res.send(pagina);
});

// Iniciando servidor
app.listen(porta, () => {
    console.log("Escutando requisições na porta " + porta);
});
