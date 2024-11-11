import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/animais_disponiveis.dart';

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
  int? _cpf;
  int? _rg;
  String? _endereco;
  String? _dataDeNascimento;
  PlatformFile? _comprovanteDeResidencia;
  String? _nomeDoAnimal;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _comprovanteDeResidencia = result.files.first;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionário para adoção'),
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
                      labelText: 'CPF',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite seu CPF';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'RG',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite seu RG';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Endereço',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite seu endereço';
                      }
                      return null;
                    },
                    onSaved: (value) => _endereco = value,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Data de nascimento',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite sua data de nascimento';
                      }
                      return null;
                    },
                    onSaved: (value) => _dataDeNascimento = value,
                  ),
                  SizedBox(height: 10),
                  // Outros campos aqui

                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickFile,
                          icon: Icon(Icons.attach_file),
                          label: Text('Selecionar comprovante de residência'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      if (_comprovanteDeResidencia != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _comprovanteDeResidencia!.name,
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
                          print('Nome: $_nome, CPF: $_cpf, RG: $_rg, Endereço: $_endereco, Data de Nascimento: $_dataDeNascimento, Comprovante de Residência: $_comprovanteDeResidencia, Nome do Animal: $_nomeDoAnimal.');
                          _showSnackBar('Questionário enviado');
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
