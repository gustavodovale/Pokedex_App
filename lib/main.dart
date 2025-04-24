import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(textTheme: GoogleFonts.pressStart2pTextTheme()),
      home: MyHomePage(title: 'Pokedex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nome = '';
  String tipos = '';
  String altura = '';
  String peso = '';
  String habilidades = '';
  String ataques = '';
  String mensagemErro = '';
  String imagem = '';

  void _procurar() async {
    if (widget.controller.text.isEmpty) {
      setState(() {
        mensagemErro = 'Por favor, digite o nome de um Pokémon.';
      });
      return;
    }

    String url =
        'https://pokeapi.co/api/v2/pokemon/${widget.controller.text.toLowerCase()}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dados = jsonDecode(response.body);

        setState(() {
          nome = dados['name'];
          altura = '${dados['height']}';
          peso = '${dados['weight']}';
          habilidades = dados['abilities']
              .map((habilidade) => habilidade['ability']['name'])
              .join(', ');
          ataques = dados['moves']
              .take(5)
              .map((ataque) => ataque['move']['name'])
              .join(', ');
          tipos = dados['types'].map((tipo) => tipo['type']['name']).join(', ');
          imagem = dados['sprites']['front_default'] ?? '';
          mensagemErro = '';
        });
      } else {
        setState(() {
          mensagemErro = 'Pokémon não encontrado.';
        });
      }
    } catch (e) {
      setState(() {
        mensagemErro = 'Erro ao buscar os dados: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(255, 22, 22, 1)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Pok%C3%A9_Ball_icon.svg/770px-Pok%C3%A9_Ball_icon.svg.png',
                ),
                width: 200,
                height: 200,
              ),
              Text(
                'Pokedex',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  labelText: 'Digite o nome do Pokémon',
                  border: OutlineInputBorder(),
                  hintText: 'Ex: Pikachu',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _procurar,
                child: Text(
                  'Procurar',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 22, 22, 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                
              ),
              const SizedBox(height: 16),
              if (mensagemErro.isNotEmpty)
                Text(
                  mensagemErro,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 231, 23, 8),
                  ),
                ),
              if (nome.isNotEmpty) ...[
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2, // Define a proporção de espaço para o texto
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome: $nome',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Tipos: $tipos',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Altura: $altura',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Peso: $peso',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Habilidades: $habilidades',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Ataques: $ataques',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ), // Espaçamento entre o texto e a imagem
                    Expanded(
                      flex: 1, // Define a proporção de espaço para a imagem
                      child: Image.network(
                        imagem,
                        width: 150, // Ajuste o tamanho da imagem
                        height: 150,
                        fit:
                            BoxFit
                                .contain, // Garante que a imagem se ajuste ao espaço disponível
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Erro ao carregar a imagem');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
