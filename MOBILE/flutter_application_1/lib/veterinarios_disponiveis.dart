import 'package:flutter/material.dart';
import 'package:flutter_application_1/animais_disponiveis.dart';


class Veterinario {
  final String nome;
  final String especializacao;
  final String telefone;
  final String endereco;
  final String cidade;
  final String imagemUrl;

  Veterinario({
    required this.nome,
    required this.especializacao,
    required this.telefone,
    required this.endereco,
    required this.cidade,
    required this.imagemUrl,
  });
}

class VeterinariosDisponiveis extends StatelessWidget {
  const VeterinariosDisponiveis({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veterinários Disponíveis',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const VeterinariosDisponiveisPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VeterinariosDisponiveisPage extends StatefulWidget {
  const VeterinariosDisponiveisPage({super.key});

  @override
  _VeterinariosDisponiveisPageState createState() =>
      _VeterinariosDisponiveisPageState();
}

class _VeterinariosDisponiveisPageState
    extends State<VeterinariosDisponiveisPage> {
  final List<Veterinario> veterinarios = [
    Veterinario(
      nome: 'Dr. João Silva',
      especializacao: 'Clinico Geral',
      telefone: '(11) 98765-4321',
      endereco: 'Rua dos Veterinários, 123 - São Paulo, SP',
      cidade: 'São Paulo',
      imagemUrl: 'assets/images/veterinario1.jpg',
    ),
    Veterinario(
      nome: 'Dra. Maria Oliveira',
      especializacao: 'Dermatologia Veterinária',
      telefone: '(11) 92345-6789',
      endereco: 'Av. Brasil, 456 - São Paulo, SP',
      cidade: 'São Paulo',
      imagemUrl: 'assets/images/veterinario2.jpg',
    ),
    // Adicione mais veterinários conforme necessário
  ];

  String? cidadeSelecionada;
  List<String> cidades = ['São Paulo', 'Rio de Janeiro', 'Curitiba', 'Belo Horizonte']; // Adicione mais cidades conforme necessário

  @override
  Widget build(BuildContext context) {
    List<Veterinario> veterinariosFiltrados = cidadeSelecionada == null
        ? veterinarios
        : veterinarios.where((vet) => vet.cidade == cidadeSelecionada).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Veterinários Disponíveis'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnimaisDisponiveis()), // Adicione a tela LoginAdministrador
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              hint: const Text('Selecionar Cidade'),
              value: cidadeSelecionada,
              onChanged: (String? novaCidade) {
                setState(() {
                  cidadeSelecionada = novaCidade;
                });
              },
              items: cidades.map((cidade) {
                return DropdownMenuItem(
                  value: cidade,
                  child: Text(cidade),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.location_city),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final veterinario = veterinariosFiltrados[index];
                        return GestureDetector(
                          onTap: () {
                            // Navegar para a página de detalhes do veterinário
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VeterinarioDetalhesPage(
                                    veterinario: veterinario),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(veterinario.imagemUrl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  color: Colors.black54,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    veterinario.nome,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: veterinariosFiltrados.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VeterinarioDetalhesPage extends StatelessWidget {
  final Veterinario veterinario;

  const VeterinarioDetalhesPage({super.key, required this.veterinario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(veterinario.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(veterinario.imagemUrl),
            const SizedBox(height: 10),
            Text(
              'Especialização: ${veterinario.especializacao}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Telefone: ${veterinario.telefone}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Endereço: ${veterinario.endereco}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para ligar para o veterinário
                _makePhoneCall(veterinario.telefone);
              },
              child: const Text('Marcar consulta'),
            ),
          ],
        ),
      ),
    );
  }

  // Função para fazer a chamada telefônica (exemplo de funcionalidade)
  void _makePhoneCall(String phoneNumber) {
    print('Ligando para $phoneNumber');
  }
}
