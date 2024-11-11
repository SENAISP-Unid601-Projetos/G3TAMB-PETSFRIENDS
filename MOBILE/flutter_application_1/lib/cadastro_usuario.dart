import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_application_1/login_usuario.dart'; // Para o uso de imagem de perfil

void main() {
  runApp(const CadastroUsuario());
}

class CadastroUsuario extends StatelessWidget {
  const CadastroUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet\'s Friends',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const RegistrationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _crmvController = TextEditingController(); // Adicionado
  File? _profileImage; // Armazena a imagem de perfil

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícone de seta
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginUsuario()),
            );// Voltar para a página anterior
          },
        ),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/fundo.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                width: 350,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Criar uma conta',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage, // Método para selecionar imagem
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.brown,
                        backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 50,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(_nameController, 'Nome Completo', Icons.person),
                    const SizedBox(height: 16),
                    _buildTextField(_emailController, 'Email', Icons.email),
                    const SizedBox(height: 16),
                    _buildTextField(_phoneController, 'Telefone', Icons.phone),
                    const SizedBox(height: 16),
                    _buildPasswordField(_passwordController, 'Senha'),
                    const SizedBox(height: 16),
                    _buildPasswordField(_confirmPasswordController, 'Confirmar Senha'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginUsuario()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                      child: const Text('Cadastrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Container(
      width: 300,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label) {
    return Container(
      width: 300,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.lock),
        ),
        obscureText: true,
      ),
    );
  }

  void _register() {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final crmv = _crmvController.text; // Captura o CRMV
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password == confirmPassword) {
      print('Nome: $name, Email: $email, Telefone: $phone, CRMV: $crmv, Senha: $password');
    } else {
      print('As senhas não coincidem.');
    }
  }

  Future<void> _pickImage() async {
    // Implementar funcionalidade de escolher imagem usando ImagePicker ou similar.
  }
}
