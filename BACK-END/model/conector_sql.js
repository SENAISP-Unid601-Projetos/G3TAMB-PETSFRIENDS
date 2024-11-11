const pg = require ("pg");
function conectaBanco(){
const dados = {
    host : "127.0.0.1",
    port: "5432",
    user: "postgres",
    password: "Lorena10!",
    database: "PETS_FRIENDS",
};

const conexao = new pg.Pool(dados);
return conexao;
}

exports.conectaBanco = conectaBanco;