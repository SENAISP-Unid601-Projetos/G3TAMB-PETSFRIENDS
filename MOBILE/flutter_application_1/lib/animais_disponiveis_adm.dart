import 'package:flutter/material.dart';
import 'package:flutter_application_1/adm_denuncia.dart';
import 'package:flutter_application_1/perfil_adm.dart';
import 'package:flutter_application_1/questionario.dart';

class AnimaisDisponiveisAdm extends StatelessWidget {
  const AnimaisDisponiveisAdm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet\'s Love'),
        automaticallyImplyLeading: false,
        actions: [
           IconButton(
            icon: Icon(Icons.app_registration_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionarioAdocao()),
              );
            },
            tooltip: 'Cadastrar animal',
          ),
           IconButton(
            icon: Icon(Icons.sim_card_alert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdmDenuncia()),
              );
            },
            tooltip: 'Denúncias',
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimaisDisponiveisAdm()),
              );
            },
            tooltip: 'Minhas Atividades',
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PerfilAdm()),
              );
            },
            tooltip: 'Perfil do Administrador',
          ),
        ],
      ),
      body: const AnimaisDisponiveisAdmPage(),
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

class AnimaisDisponiveisAdmPage extends StatefulWidget {
  const AnimaisDisponiveisAdmPage({super.key});

  @override
  _AnimaisDisponiveisAdmPageState createState() => _AnimaisDisponiveisAdmPageState();
}

class _AnimaisDisponiveisAdmPageState extends State<AnimaisDisponiveisAdmPage> {
  final List<Animal> animais = [
    Animal(
      nome: 'Chorão',
      raca: 'Sem raça definida',
      idade: '4 meses',
      descricao: 'Macho, porte pequeno e peludo.',
      imagemUrl: 'assets/images/cach1.jpg',
    ),
     Animal(
      nome: 'Sem nome definido',
      raca: 'Sem raça definida(SRD)',
      idade: '2 meses',
      descricao: 'Fêmea',
      imagemUrl: 'assets/images/gato1.jpg',
    ),
    Animal(
      nome: 'Sem nome definido',
      raca: 'Sem raça definida(SRD)',
      idade: '2 meses',
      descricao: 'Fêmea',
      imagemUrl: 'assets/images/gato2.jpg',
    ),
    Animal(
      nome: 'Katau',
      raca: 'Sem raça definido(SRD)',
      idade: '4 meses',
      descricao: 'Macho de porte grande',
      imagemUrl: 'assets/images/cach2.jpg',
    ),
    Animal(
      nome: 'Estopinha',
      raca: 'Sem raça definida(SRD)',
      idade: '3 anos',
      descricao: 'Macho de porte pequeno',
      imagemUrl: 'assets/images/cach3.jpg',
    ),
    Animal(
      nome: 'Aparecidinha',
      raca: 'Sem raça definida(SRD)',
      idade: '3 meses',
      descricao: 'Fêmea de porte grande',
      imagemUrl: 'assets/images/cach4.jpg',
    ),
    Animal(
      nome: 'Luffy',
      raca: 'Sem raça definida(SRD)',
      idade: '2 anos',
      descricao: 'Macho de porte pequeno',
      imagemUrl: 'assets/images/cach5.jpg',
    ),
  ];


  List<Animal> get filteredAnimals {
    return animais;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                            left: 10,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _editarAnimal(context, animal);
                              },
                              icon: Icon(Icons.edit),
                              label: Text(''),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _excluirAnimal(context, animal);
                              },
                              icon: Icon(Icons.delete),
                              label: Text(''),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
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
    );
  }

  void _editarAnimal(BuildContext context, Animal animal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar ${animal.nome}'),
          content: Text('Aqui será o formulário de edição para o animal.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Implementar lógica de edição
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirAnimal(BuildContext context, Animal animal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir ${animal.nome}'),
          content: Text('Tem certeza de que deseja excluir este animal?'),
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
                  animais.remove(animal);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${animal.nome} foi excluído com sucesso.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}

class _showAnimalDetails {
  _showAnimalDetails(BuildContext context, Animal animal);
}
