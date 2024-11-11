import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_usuario.dart';
import 'package:flutter_application_1/login_veterinario.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fundo.png'),
                fit: BoxFit.cover, // Expande a imagem para cobrir toda a tela
              ),
            ),
          ),
          
          // Conteúdo da página
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                Image.asset('assets/images/logo.png',width: 220,), // Logo
                const SizedBox(height: 20),
                
                // Retângulo reto com sombra em cima e embaixo
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 300, // Definindo uma largura máxima
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 225, 170),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, -10), // Sombra em cima
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 10), // Sombra embaixo
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Bem-vindo ao Pet\'s Friends!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Aqui você pode adotar, doar e cuidar de seus amigos de quatro patas 🐾',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Botão "Usuários" maior
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          minimumSize: const Size(200, 50),
                        ),
                        onPressed: () {
                          // Navegação para Cadastro de Usuários
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginUsuario()),
                          );
                        },
                        child: const Text(
                          'Usuários',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Botão "Veterinários" maior
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          minimumSize: const Size(200, 50),
                        ),
                        onPressed: () {
                          // Navegação para Cadastro de Veterinários
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginVeterinario()),
                          );
                        },
                        child: const Text(
                          'Veterinários',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                // Fim do retângulo reto
              ],
            ),
          ),
        ],
      ),
    );
  }
}
