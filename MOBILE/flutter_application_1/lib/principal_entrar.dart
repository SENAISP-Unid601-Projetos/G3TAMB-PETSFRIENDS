import 'package:flutter/material.dart';

void main() {
  runApp(AdocaoApp());
}

class AdocaoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serviços de Adoção de Animais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ServicosPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ServicosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços de Adoção de Animais'),
      ),
      body: Stack(
        children: <Widget>[
          // Adiciona a imagem de fundo
          Positioned.fill(
            child: Image.asset(
              'assets/images/fundo.png', // Substitua pelo caminho da sua imagem
              fit: BoxFit.cover,
            ),
          ),
          // Adiciona o conteúdo sobre a imagem de fundo
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Text(
                    'Nossos Serviços',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Ajuste a cor do texto conforme necessário
                    ),
                  ),
                ),
                const SizedBox(height: 32.0), // Espaço entre o título e as caixas de texto
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          _buildServiceBox('Formulário de Adoção', 'Preencha o formulário para adotar seu próximo amigo.'),
                          _buildServiceBox('Perfil Detalhado dos Cães', 'Veja informações detalhadas sobre os cães disponíveis para adoção.'),
                          _buildServiceBox('Campanhas de Castração', 'Participe das campanhas para controle populacional de animais.'),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildServiceBox('Realizar Doação', 'Ajude os animais com doações de alimentos, medicamentos e mais.'),
                            _buildServiceBox('Chat com Veterinários', 'Converse diretamente com veterinários sobre o bem-estar do seu pet.'),
                            _buildServiceBox('Realizar Denúncias', 'Denuncie maus-tratos ou abandono de animais de forma rápida e segura.'),
                          ],
                        ),
                      )
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

  // Função auxiliar para criar cada caixa de serviço com título e descrição
  Widget _buildServiceBox(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 209, 174, 99), // Adiciona uma leve opacidade para o fundo das caixas
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Color.fromARGB(255, 173, 131, 62), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Ajuste a cor do texto conforme necessário
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 16.0, color: Colors.white), // Ajuste a cor do texto conforme necessário
            ),
          ],
        ),
      ),
    );
  }
}
