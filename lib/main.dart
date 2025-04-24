import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 212, 5, 5)),
      ),
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

  void _procurar() async {
    if (widget.controller.text.isEmpty) {
      setState(() {
        mensagemErro = 'Por favor, digite o nome de um Pokémon.';
      });
      return;
    }

    String url = 'https://pokeapi.co/api/v2/pokemon/${widget.controller.text.toLowerCase()}';

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
          tipos = dados['types']
              .map((tipo) => tipo['type']['name'])
              .join(', ');
          mensagemErro = ''; // Limpa a mensagem de erro
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pokedex',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                labelText: 'Digite o nome do Pokémon',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _procurar,
              child: const Text('Procurar'),
            ),
            if (mensagemErro.isNotEmpty)
              Text(
                mensagemErro,
                style: const TextStyle(color: Color.fromARGB(255, 231, 23, 8)),
              ),
            if (nome.isNotEmpty) ...[
              Text('Nome: $nome'),
              Text('Tipos: $tipos'),
              Text('Altura: $altura'),
              Text('Peso: $peso'),
              Text('Habilidades: $habilidades'),
              Text('Ataques: $ataques'),
            ],
          ],
        ),
      ),
    );
  }
}