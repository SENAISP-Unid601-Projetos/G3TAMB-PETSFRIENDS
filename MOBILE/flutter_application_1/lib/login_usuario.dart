import 'package:flutter/material.dart';
import 'package:flutter_application_1/animais_disponiveis.dart';
import 'package:flutter_application_1/cadastro_usuario.dart';
import 'package:flutter_application_1/esqueci_a_senha.dart';
import 'package:flutter_application_1/main.dart'; // Supondo que MyApp seja a página inicial

void main() {
  runApp(const LoginUsuario());
}

class LoginUsuario extends StatelessWidget {
  const LoginUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet\'s Friends',
      theme: ThemeData(
        primarySwatch: Colors.brown, // Cor de fundo da página
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícone de seta
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()), // Voltar para a página inicial
            );
          },
        ),
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          SizedBox.expand(
            child: Image.asset(
              'assets/images/fundo.png', // Caminho para a imagem de fundo
              fit: BoxFit.cover, // Ajusta a imagem ao tamanho da tela
            ),
          ),
          // Conteúdo sobre a imagem
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Caixa com relevo e fundo branco
                Container(
                  padding: const EdgeInsets.all(16),
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255), // Fundo branco
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4), // Sombra abaixo do container
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png', width: 150),
                      const SizedBox(height: 20),
                      const Text(
                        'Bem-vindo ao Pet\'s Friends!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Campo de email
                      Container(
                        width: 300,
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Campo de senha
                      Container(
                        width: 300,
                        child: TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Botões "Entrar" e "Entrar como Administrador"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Botão "Entrar"
                          ElevatedButton(
                            onPressed: () {
                              _login();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AnimaisDisponiveis()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            ),
                            child: const Text('Entrar'),
                          ),
                          const SizedBox(width: 16), // Espaço entre os botões
                          // Botão "Entrar como Administrador"
                          ElevatedButton(
                            onPressed: () {
                              // Navegar para a tela de login do administrador (crie esta tela conforme necessário)
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CadastroUsuario()), // Adicione a tela LoginAdministrador
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            ),
                            child: const Text('Administrador'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Links de ação
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Ação ao clicar em "Esqueci minha senha"
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordApp()),
                              );
                            },
                            child: const Text(
                              'Esqueci minha senha',
                              style: TextStyle(color: Colors.brown),
                            ),
                          ),
                          const SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              // Ação ao clicar em "Cadastrar-se"
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CadastroUsuario()),
                              );
                            },
                            child: const Text(
                              'Cadastrar-se',
                              style: TextStyle(color: Colors.brown),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    print('Email: $email, Senha: $password');
  }
}
