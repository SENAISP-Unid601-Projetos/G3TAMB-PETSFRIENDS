const clientes = require("../model/clientes.js");

async function consultaTodosClientes(req, res) {
    const resposta = await clientes.getClientes();
    res.json(resposta);
}

async function consultaCliente(req, res) {
    const dados = req.body;
    const resposta = await clientes.getCliente(dados);
    res.json(resposta);
}

async function cadastraCliente(req, res) {
    const resposta = await clientes.insertClientes(req.body);
    res.json(resposta);
}

exports.consultaTodosClientes = consultaTodosClientes;
exports.consultaCliente = consultaCliente;
exports.cadastraCliente = cadastraCliente;