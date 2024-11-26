import 'package:flutter/material.dart';
import 'package:flutter_application_1/animais_disponiveis.dart';


class AdocaoTete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Animais',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DetalhesAnimal(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DetalhesAnimal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBar(
        title: Text('Adoçao de animal'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ],
    );
  
    return MaterialApp(
      title: 'Pet\'s Love',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdocaoPage(
      animal: Animal(
      nome: 'Chorão',
      raca: 'Sem raça definida',
      idade: '4 meses',
      descricao: 'Macho, porte pequeno e peludo.',
      imagemUrl: 'assets/images/cach1.jpg',
    ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Animal {
  final String nome;
  final String raca;
  final String idade;
  final String descricao;
  final String imagemUrl;

  Animal({
    required this.nome,
    required this.raca,
    required this.idade,
    required this.descricao,
    required this.imagemUrl,
  });
}

class AdocaoPage extends StatelessWidget {
  final Animal animal;

  AdocaoPage({required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do ${animal.nome}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagem Retangular Grande
            Container(
              height: 400,  // Aumenta a altura da imagem
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(animal.imagemUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Informações do Animal
            Text(
              animal.nome,
              style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.pets, color: Colors.grey[700]),
                SizedBox(width: 8),
                Text(
                  'Raça: ${animal.raca}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.cake, color: Colors.grey[700]),
                SizedBox(width: 8),
                Text(
                  'Idade: ${animal.idade}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              animal.descricao,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Spacer(),

            // Botão de Adoção
            ElevatedButton(
              onPressed: () {
                _adotarAnimal(context);
              },
              child: Text('Adotar ${animal.nome}'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _adotarAnimal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Parabéns!"),
        content: Text("Você iniciou o processo de adoção do(a) ${animal.nome}."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimaisDisponiveis()),
              );
            },
            child: Text('Continuar'),
          ),
        ],
      ),
    );
  }
}
