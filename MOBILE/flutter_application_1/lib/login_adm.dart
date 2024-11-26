import 'package:flutter/material.dart';
import 'package:flutter_application_1/animais_disponiveis_adm.dart';
import 'main.dart';

void main() {
  runApp(const LoginAdm());
}

class LoginAdm extends StatelessWidget {
  const LoginAdm({super.key});

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
        title: Text('Login ADM'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()), // Adicione a tela LoginAdministrador
              );
            },
          ),
        ],
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: const Offset(0, 4), // Sombra abaixo do container
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
                      // Botão "Entrar"
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AnimaisDisponiveisAdm()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        ),
                        child: const Text('Entrar'),
                      ),
                      const SizedBox(height: 16),
                      // Links de ação
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Ação ao clicar em "Esqueci minha senha"
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
