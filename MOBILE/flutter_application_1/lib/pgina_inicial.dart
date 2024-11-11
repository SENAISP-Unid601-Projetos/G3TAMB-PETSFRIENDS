import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adoção de Cachorros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoção de Cachorros'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo ao app de Adoção de Cachorros!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/dog.png', // Certifique-se de adicionar uma imagem de cachorro aqui
              height: 200,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navegação para a página de cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaCadastro()),
                );
              },
              child: Text('Cadastrar-se'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: Text(
          'Página de cadastro em construção!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
