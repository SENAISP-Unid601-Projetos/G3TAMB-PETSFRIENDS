import 'package:flutter/material.dart';
import 'package:flutter_application_1/animais_disponiveis_adm.dart';
import 'main.dart';


class PerfilAdm extends StatelessWidget {
  const PerfilAdm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil do Usuário',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PerfilAdmPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PerfilAdmPage extends StatefulWidget {
  @override
  _PerfilAdmPageState createState() => _PerfilAdmPageState();
}

class _PerfilAdmPageState extends State<PerfilAdmPage> {
  String nome = "Cleisson Marinho";
  String email = "Cleisson.Marinho@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Administrador'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnimaisDisponiveisAdm()), // Adicione a tela LoginAdministrador
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
              ),
            ),
            SizedBox(height: 20),
            Text('Nome: $nome', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Email: $email', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarDadosPage(
                      nome: nome,
                      email: email,
                      onSave: (String novoNome, String novoEmail) {
                        setState(() {
                          nome = novoNome;
                          email = novoEmail;
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Mudar os Dados'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Animais Disponíveis para Adoção'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AnimaisDisponiveisAdm()),
                );
                
              },
            ),
           Divider(),
ListTile(
  leading: Icon(Icons.logout),
  title: Text('Sair'),
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Tem certeza que deseja sair?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text('Sair'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );// Fecha o diálogo
                // Adicione aqui a ação de logout ou redirecionamento
              },
            ),
          ],
        );
      },
    );
  },
),
          ],
        ),
      ),
    );
  }
}

class EditarDadosPage extends StatefulWidget {
  final String nome;
  final String email;
  final Function(String, String) onSave;

  EditarDadosPage({required this.nome, required this.email, required this.onSave});

  @override
  _EditarDadosPageState createState() => _EditarDadosPageState();
}

class _EditarDadosPageState extends State<EditarDadosPage> {
  late TextEditingController nomeController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.nome);
    emailController = TextEditingController(text: widget.email);
  }

  void _confirmarEmailAntesDeSalvar() {
    // Mostrar um diálogo para confirmar o email
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação de Email'),
          content: Text('Confira se o e-mail informado está correto: ${emailController.text}'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo sem salvar
              },
            ),
            TextButton(
              child: Text('Confirmar e Salvar'),
              onPressed: () {
                widget.onSave(nomeController.text, emailController.text); // Salva os dados
                Navigator.of(context).pop(); // Fecha o diálogo de confirmação
                Navigator.of(context).pop(); // Volta à página de perfil
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _confirmarEmailAntesDeSalvar();
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
