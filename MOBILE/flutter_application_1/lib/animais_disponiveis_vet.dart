import 'package:flutter/material.dart';

class AnimaisDisponiveisVet extends StatelessWidget {
  const AnimaisDisponiveisVet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultas do Veterinário'),
        automaticallyImplyLeading: false,
      ),
      body: ConsultasVetPage(),
    );
  }
}

class Consulta {
  final String nomeTutor;
  final String nomeAnimal;
  final String dataConsulta;
  final String descricao;

  Consulta({
    required this.nomeTutor,
    required this.nomeAnimal,
    required this.dataConsulta,
    required this.descricao,
  });
}

class ConsultasVetPage extends StatelessWidget {
  ConsultasVetPage({super.key});

  final List<Consulta> consultas = [
    Consulta(
      nomeTutor: 'João Silva',
      nomeAnimal: 'Nina',
      dataConsulta: '19/11/2024',
      descricao: 'Consulta de rotina.',
    ),
    Consulta(
      nomeTutor: 'Maria Souza',
      nomeAnimal: 'Juca',
      dataConsulta: '20/11/2024',
      descricao: 'Revisão de vacinação.',
    ),
    Consulta(
      nomeTutor: 'Ana Lima',
      nomeAnimal: 'Bob',
      dataConsulta: '21/11/2024',
      descricao: 'Exame de alergias.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: consultas.length,
      itemBuilder: (context, index) {
        final consulta = consultas[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(
                consulta.nomeAnimal[0], // Primeira letra do nome do animal
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              "${consulta.nomeAnimal} - ${consulta.dataConsulta}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Tutor: ${consulta.nomeTutor}\nDescrição: ${consulta.descricao}",
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showConsultaDetalhes(context, consulta);
            },
          ),
        );
      },
    );
  }

  void _showConsultaDetalhes(BuildContext context, Consulta consulta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalhes da Consulta'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tutor: ${consulta.nomeTutor}'),
              Text('Animal: ${consulta.nomeAnimal}'),
              Text('Data: ${consulta.dataConsulta}'),
              Text('Descrição: ${consulta.descricao}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Ação para confirmar consulta
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MensagemPage(
                      mensagem: 'Consulta Confirmada!',
                      color: Colors.green,
                    ),
                  ),
                );
              },
              child: const Text('Confirmar Consulta'),
            ),
            TextButton(
              onPressed: () {
                // Ação para cancelar consulta
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MensagemPage(
                      mensagem: 'Consulta Cancelada!',
                      color: Colors.red,
                    ),
                  ),
                );
              },
              child: const Text('Cancelar Consulta'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}

class MensagemPage extends StatelessWidget {
  final String mensagem;
  final Color color;

  const MensagemPage({super.key, required this.mensagem, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status da Consulta'),
        backgroundColor: color,
      ),
      body: Center(
        child: Text(
          mensagem,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
