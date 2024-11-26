import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Denúncias de Usuários',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DenunciasAdmPage(),
    );
  }
}

class Denuncia {
  final String usuario;
  final String localizacao;
  final String tipoAnimal;
  final String situacao;
  final String mensagem;
  final String? imagemUrl;

  Denuncia({
    required this.usuario,
    required this.localizacao,
    required this.tipoAnimal,
    required this.situacao,
    required this.mensagem,
    this.imagemUrl,
  });
}

class DenunciasAdmPage extends StatelessWidget {
  final List<Denuncia> denuncias = [
    Denuncia(
      usuario: 'João',
      localizacao: 'Rua das Flores, 123',
      tipoAnimal: 'Cachorro',
      situacao: 'Maus tratos',
      mensagem: 'Animal preso em um espaço pequeno.',
      imagemUrl: 'assets/images/cachorro_maltrato.jpg',
    ),
    Denuncia(
      usuario: 'Maria',
      localizacao: 'Av. Brasil, 456',
      tipoAnimal: 'Gato',
      situacao: 'Abandono',
      mensagem: 'Gato abandonado na rua por vários dias.',
      imagemUrl: 'assets/images/gato_abandono.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Denúncias de Usuários'),
      ),
      body: ListView.builder(
        itemCount: denuncias.length,
        itemBuilder: (context, index) {
          final denuncia = denuncias[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              title: Text('Usuário: ${denuncia.usuario}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Localização: ${denuncia.localizacao}'),
                  Text('Tipo de Animal: ${denuncia.tipoAnimal}'),
                  Text('Situação: ${denuncia.situacao}'),
                  Text('Mensagem: ${denuncia.mensagem}'),
                  if (denuncia.imagemUrl != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(denuncia.imagemUrl!, height: 100),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
