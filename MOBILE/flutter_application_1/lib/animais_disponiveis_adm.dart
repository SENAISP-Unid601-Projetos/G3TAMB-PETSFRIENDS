import 'package:flutter/material.dart';
import 'package:flutter_application_1/cancelar_adocao.dart';
import 'package:flutter_application_1/perfil_usuario.dart';

class AnimaisDisponiveisAdm extends StatelessWidget {
  const AnimaisDisponiveisAdm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet\'s Love',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AnimaisDisponiveisPage(),
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

class AnimaisDisponiveisPage extends StatefulWidget {
  const AnimaisDisponiveisPage({super.key});

  @override
  _AnimaisDisponiveisPageState createState() => _AnimaisDisponiveisPageState();
}

class _AnimaisDisponiveisPageState extends State<AnimaisDisponiveisPage> {
  final List<Animal> animais = [
    Animal(
      Nome: 'Tete',
      raca: 'Labrador retriever',
      idade: '2 anos',
      descricao: 'Brincalhão e carinhoso.',
      imagemUrl: 'assets/images/labrador.webp',
    ),
    Animal(
      Nome: 'Gamora',
      raca: 'SRD',
      idade: '3 anos',
      descricao: 'Amorosa e ama crianças. Foi resgatada das ruas.',
      imagemUrl: 'assets/images/srd.jpg',
    ),
    // Adicione outros animais aqui
  ];

  bool denunciaEnviada = false;
  bool denunciaVisualizada = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 260.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  ),
                  background: Container(color: Colors.white),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cancelaradocao()),
                      );
                    },
                    tooltip: 'Minhas Atividades',
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PerfilUsuarioPage()),
                      );
                    },
                    tooltip: 'Perfil do Usuário',
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final animal = animais[index];
                      return GestureDetector(
                        child: Container(
                          height: 450,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 400,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(animal.imagemUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      );
                    },
                    childCount: animais.length,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Função de denúncia
              },
              child: Icon(Icons.warning),
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Animal animal, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Animal'),
          content: Text('Tem certeza que deseja excluir ${animal.Nome}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  animais.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
