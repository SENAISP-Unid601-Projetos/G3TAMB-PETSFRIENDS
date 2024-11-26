import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/animais_disponiveis_adm.dart';

class QuestionarioAdocao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Animais',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AnimalRegistrationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnimalRegistrationPage extends StatefulWidget {
  @override
  _AnimalRegistrationPageState createState() => _AnimalRegistrationPageState();
}

class _AnimalRegistrationPageState extends State<AnimalRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _nome;
  String? _raca;
  int? _idade;
  String? _diagnostico;
  String? _status;
  // ignore: unused_field
  String? _estado;
  PlatformFile? _imagem;

 Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _imagem = result.files.first;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar animal'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnimaisDisponiveisAdm()), // Adicione a tela LoginAdministrador
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/img1.jpg',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome completo',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite seu nome completo';
                      }
                      return null;
                    },
                    onSaved: (value) => _nome = value,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Raça',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a raça do seu animal';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Idade',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a idade do seu animal';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Diagnóstico',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o diagnóstico do seu animal';
                      }
                      return null;
                    },
                    onSaved: (value) => _diagnostico = value,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Status',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o status do animal';
                      }
                      return null;
                    },
                    onSaved: (value) => _status = value,
                  ),
                   SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Estado',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o estado de saude do animal';
                      }
                      return null;
                    },
                    onSaved: (value) => _estado = value,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickFile,
                          icon: Icon(Icons.attach_file),
                          label: Text('Selecionar a imagem do animal'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      if (_imagem != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _imagem!.name,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                    ],
                  ),
                 
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print('Nome: $_nome, Raça: $_raca, Idade: $_idade, Diagnóstico: $_diagnostico, Status: $_status, Imagem: $_imagem, Nome do Animal: $_estado.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Questionário enviado'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 240, 225, 183),
                        foregroundColor: Colors.black,
                        minimumSize: Size(150, 50),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: Text('Cadastrar Animal'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
