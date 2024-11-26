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

async function atualizaCliente(req, res) {
    const resposta = await clientes.updateClientes(req.body);
    res.json(resposta);
}

async function excluiCliente(req, res) {
    const resposta = await clientes.deleteClientes(req.body);
    res.json(resposta);
}

exports.consultaTodosClientes = consultaTodosClientes;
exports.consultaCliente = consultaCliente;
exports.cadastraCliente = cadastraCliente;
exports.atualizaCliente = atualizaCliente;
exports.excluiCliente = excluiCliente;