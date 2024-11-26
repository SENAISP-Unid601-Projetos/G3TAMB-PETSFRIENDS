import 'package:flutter/material.dart';
import 'package:flutter_application_1/adocao_chorao.dart';
import 'package:flutter_application_1/cancelar_adocao.dart';
import 'package:flutter_application_1/perfil_usuario.dart';
import 'package:flutter_application_1/veterinarios_disponiveis.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AnimaisDisponiveis extends StatelessWidget {
  const AnimaisDisponiveis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet\'s Love'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.medical_services),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VeterinariosDisponiveis()),
              );
            },
            tooltip: 'Veterinários Disponíveis',
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MinhasAdocoesPage()),
              );
            },
            tooltip: 'Minhas Atividades',
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
      body: const AnimaisDisponiveisPage(),
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

class AnimaisDisponiveisPage extends StatefulWidget {
  const AnimaisDisponiveisPage({super.key});

  @override
  _AnimaisDisponiveisPageState createState() => _AnimaisDisponiveisPageState();
}

class _AnimaisDisponiveisPageState extends State<AnimaisDisponiveisPage> {
  bool denunciaEnviada = false;
  bool denunciaVisualizada = false;
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  final List<Animal> animais = [
      Animal(
      nome: 'Chorão',
      raca: 'Sem raça definida(SRD)',
      idade: '4 meses',
      descricao: 'Macho, porte pequeno e peludo.',
      imagemUrl: 'assets/images/cach1.jpg',
    ),
      Animal(
      nome: 'Sem nome definido',
      raca: 'Sem raça definida(SRD)',
      idade: '2 meses',
      descricao: 'Femêa',
      imagemUrl: 'assets/images/gato1.jpg',
    ),
    Animal(
      nome: 'Sem nome definido',
      raca: 'Sem raça definida(SRD)',
      idade: '2 meses',
      descricao: 'Femêa',
      imagemUrl: 'assets/images/gato2.jpg',
    ),
    Animal(
      nome: 'Katau',
      raca: 'Sem raça definido(SRD)',
      idade: '4 meses',
      descricao: 'Macho com porte grande',
      imagemUrl: 'assets/images/cach2.jpg',
    ),
    Animal(
      nome: 'Estopinha',
      raca: 'Sem raça definida(SRD)',
      idade: '3 anos',
      descricao: 'Macho e porte pequeno',
      imagemUrl: 'assets/images/cach3.jpg',
    ),
    Animal(
      nome: 'Aparecidinha',
      raca: 'Sem raça definida(SRD)',
      idade: '3 meses',
      descricao: 'Femêa com porte grande',
      imagemUrl: 'assets/images/cach4.jpg',
    ),
    Animal(
      nome: 'Luffy',
      raca: 'Sem raça definida(SRD)',
      idade: '2 anos',
      descricao: 'MAcho com porte pequeno',
      imagemUrl: 'assets/images/cach5.jpg',
    ),
  ];

  List<Animal> get filteredAnimals {
    if (searchQuery.isEmpty) {
      return animais;
    }
    return animais.where((animal) {
      return animal.nome.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar por nome do animal',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
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
                            final animal = filteredAnimals[index];
                            return GestureDetector(
                              onTap: () => _showAnimalDetails(context, animal),
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
                                    Positioned(
                                      bottom: 10,
                                      left: 60,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => DetalhesAnimal()),
                                          );
                                        },
                                        child: Text('Detalhes'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: filteredAnimals.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                _showDenunciaDialog(context);
              },
              child: Icon(Icons.warning),
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showAnimalDetails(BuildContext context, Animal animal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(animal.nome),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(animal.imagemUrl, height: 100, fit: BoxFit.cover),
              SizedBox(height: 10),
              Text('Raça: ${animal.raca}'),
              Text('Idade: ${animal.idade}'),
              Text('Descrição: ${animal.descricao}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showDenunciaDialog(BuildContext context) async {
    final TextEditingController usuarioController = TextEditingController();
    final TextEditingController mensagemController = TextEditingController();
    final TextEditingController localizacaoController = TextEditingController();
    String tipoAnimal = 'Cachorro';
    String situacao = 'Maus tratos';
    XFile? imagemSelecionada;
    final ImagePicker picker = ImagePicker();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Denunciar Maus-tratos'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: usuarioController,
                  decoration: InputDecoration(labelText: 'Usuário'),
                ),
                TextField(
                  controller: mensagemController,
                  decoration: InputDecoration(labelText: 'Mensagem'),
                ),
                TextField(
                  controller: localizacaoController,
                  decoration: InputDecoration(labelText: 'Localização'),
                ),
                DropdownButtonFormField<String>(
                  value: tipoAnimal,
                  items: ['Cachorro', 'Gato', 'Outro'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      tipoAnimal = newValue!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Tipo de Animal'),
                ),
                DropdownButtonFormField<String>(
                  value: situacao,
                  items: ['Maus tratos', 'Abandono', 'Outro'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      situacao = newValue!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Situação'),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        imagemSelecionada = image;
                      });
                    }
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Adicionar Foto (Opcional)'),
                ),
                if (imagemSelecionada != null) ...[
                  SizedBox(height: 10),
                  Image.file(
                    File(imagemSelecionada!.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ]
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  denunciaEnviada = true;
                  denunciaVisualizada = true;
                });

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sua denúncia já foi entregue para nossos administradores.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              child: Text('Enviar Denúncia'),
            ),
          ],
        );
      },
    );
  }
}