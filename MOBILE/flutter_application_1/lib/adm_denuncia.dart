import 'package:flutter/material.dart';
import 'package:flutter_application_1/animais_disponiveis_adm.dart';

class AdmDenuncia extends StatelessWidget {
  const AdmDenuncia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Denúncias de Maus-Tratos',
    
      theme: ThemeData(primarySwatch: Colors.brown),
      home: DenunciasScreen(),
    );
  }
}

class DenunciasScreen extends StatelessWidget {
  final List<Map<String, String>> denuncias = [
    {
      "id": "001",
      "data": "19/11/2024",
      "usuario": "Helena Maria",
      "animal": "Cachorro",
      "situacao": "Maus tratos",
      "localizacao": "Rua das Flores, 12"
    },
    {
      "id": "002",
      "data": "18/11/2024",
      "usuario": "Maria Souza",
      "animal": "Gato",
      "situacao": "Abandono",
      "localizacao": "Av. Central, 45"
    },
    {
      "id": "003",
      "data": "17/11/2024",
      "usuario": "Helena MAria",
      "animal": "Cachorro",
      "situacao": "Abandono de cachorro",
      "localizacao": "Avenida Brasil"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Denúncias de Maus-Tratos"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnimaisDisponiveisAdm()), 
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fundo.png"), // Caminho da imagem
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Conteúdo da tela
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: denuncias.length,
              itemBuilder: (context, index) {
                final denuncia = denuncias[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.brown,
                      child: Text(
                        denuncia["id"]!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      "${denuncia["animal"]} - ${denuncia["situacao"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Usuário: ${denuncia["usuario"]}\nLocalização: ${denuncia["localizacao"]}",
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesDenunciaScreen(
                            denuncia: denuncia,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetalhesDenunciaScreen extends StatelessWidget {
  final Map<String, String> denuncia;

  const DetalhesDenunciaScreen({required this.denuncia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Denúncia"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detalhes da Denúncia",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text("ID: ${denuncia["id"]}", style: TextStyle(fontSize: 16)),
            Text("Data: ${denuncia["data"]}", style: TextStyle(fontSize: 16)),
            Text("Usuário: ${denuncia["usuario"]}", style: TextStyle(fontSize: 16)),
            Text("Animal: ${denuncia["animal"]}", style: TextStyle(fontSize: 16)),
            Text("Situação: ${denuncia["situacao"]}", style: TextStyle(fontSize: 16)),
            Text("Localização: ${denuncia["localizacao"]}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Encaminhado às autoridades")),
                    );
                  },
                  icon: Icon(Icons.send),
                  label: Text("Encaminhar"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Marcado como resolvido")),
                    );
                  },
                  icon: Icon(Icons.check),
                  label: Text("Resolver"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Denúncia excluída")),
                    );
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Excluir"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
