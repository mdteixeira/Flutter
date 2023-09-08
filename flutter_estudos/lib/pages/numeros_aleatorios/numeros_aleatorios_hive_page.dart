// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int? numeroGerado = 0;
  int? quantidadeClicks = 0;
  final CHAVE_NUMERO_ALEATORIO = 'numero_aleatorio';
  final CHAVE_QUANTIDADE_CLIQUES = 'quantidade_cliques';

  late Box box_numeros_aleatorios;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      box_numeros_aleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      box_numeros_aleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    numeroGerado = box_numeros_aleatorios.get('numeroGerado');
    quantidadeClicks = box_numeros_aleatorios.get('quantidadeCliques');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Gerador de números (Hive)')),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            numeroGerado == null
                ? "Nenhum número gerado"
                : numeroGerado.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Text(
            quantidadeClicks == null
                ? "Nenhum clique efetuado"
                : '$quantidadeClicks cliques',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(100);
              quantidadeClicks = (quantidadeClicks ?? 0) + 1;
            });
            box_numeros_aleatorios.put('numeroGerado', numeroGerado);
            box_numeros_aleatorios.put('quantidadeCliques', quantidadeClicks);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
