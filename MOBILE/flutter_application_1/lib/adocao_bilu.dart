import 'package:flutter/material.dart';
import 'package:flutter_application_1/questionario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
    return MaterialApp(
      title: 'Pet\'s Love',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdocaoPage(
        animal: Animal(
          Nome: 'Bilu',
          raca: 'Persa',
          idade: '3 anos',
          descricao: 'Calmo e sociável.',
          imagemUrl: 'assets/images/persa.jpg',
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Animal {
  final String Nome;
  final String raca;
  final String idade;
  final String descricao;
  final String imagemUrl;

  Animal({
    required this.Nome,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícone de seta
          onPressed: () {},
        ),
        title: Text('Detalhes do ${animal.Nome}'),
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
              animal.Nome,
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
              child: Text('Adotar ${animal.Nome}'),
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
        content: Text("Você iniciou o processo de adoção do(a) ${animal.Nome}."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionarioAdocao()),
              );
            },
            child: Text('Continuar'),
          ),
        ],
      ),
    );
  }
}