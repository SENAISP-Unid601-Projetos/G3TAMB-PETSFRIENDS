import 'package:flutter/material.dart';

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
  String? _sexo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Animais'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
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
                      'assets/images/img.jpg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome do Animal',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o nome do animal';
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
                        return 'Digite a raça do animal';
                      }
                      return null;
                    },
                    onSaved: (value) => _raca = value,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Idade',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a idade do animal';
                      }
                      return null;
                    },
                    onSaved: (value) => _idade = int.tryParse(value!),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text('Macho'),
                          value: 'Macho',
                          groupValue: _sexo,
                          onChanged: (value) {
                            setState(() {
                              _sexo = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text('Fêmea'),
                          value: 'Fêmea',
                          groupValue: _sexo,
                          onChanged: (value) {
                            setState(() {
                              _sexo = value;
                            });
                          },
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
                          print('Animal cadastrado: $_nome, $_raca, $_idade, $_sexo');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 240, 225, 183), // Nova cor de fundo do botão
                        foregroundColor: Colors.black, // Cor da letra do botão
                        minimumSize: Size(150, 50), // Tamanho menor do botão
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
