import 'package:flutter/material.dart';
import 'package:flutter_application_1/animais_disponiveis.dart';

class Cancelaradocao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Atividades',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MinhasAdocoesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MinhasAdocoesPage extends StatelessWidget {
  final List<Adocao> adocoes = [
    Adocao('Nome: Tete', 'Raça: Labrador Retriever', 'assets/images/labrador.webp'),
    Adocao('Nome: Mimi', 'Raça: Gato Persa', 'assets/images/persa.jpg'),
  ];

  final List<Denuncia> denuncias = [
    Denuncia('Denúncia de Maus-Tratos', 'Em análise'),
    Denuncia('Denúncia de Abandono', 'Concluída'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Atividades'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnimaisDisponiveis()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAdocoesSection(),
            _buildDenunciasSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdocoesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Minhas Adoções',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: adocoes.length,
          itemBuilder: (context, index) {
            final adocao = adocoes[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        adocao.foto,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            adocao.nome,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            adocao.raca,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _confirmarCancelamento(context, adocao.nome);
                      },
                      child: Text(
                        'Cancelar Adoção',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDenunciasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Status das Denúncias',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: denuncias.length,
          itemBuilder: (context, index) {
            final denuncia = denuncias[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(denuncia.tipo),
                subtitle: Text('Status: ${denuncia.status}'),
              ),
            );
          },
        ),
      ],
    );
  }

  void _confirmarCancelamento(BuildContext context, String nomeAnimal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancelar Adoção'),
        content: Text('Você tem certeza que deseja cancelar a adoção de $nomeAnimal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Não'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Adoção de $nomeAnimal cancelada com sucesso!')),
              );
            },
            child: Text('Sim'),
          ),
        ],
      ),
    );
  }
}

class Adocao {
  final String nome;
  final String raca;
  final String foto;

  Adocao(this.nome, this.raca, this.foto);
}

class Denuncia {
  final String tipo;
  final String status;

  Denuncia(this.tipo, this.status);
}
