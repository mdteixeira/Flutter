import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/tarefa.dart';
import 'package:flutter_estudos/repositories/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var _tarefas = const <Tarefa>[];
  var descricaoController = TextEditingController();

  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    if (apenasNaoConcluidos) {
      _tarefas = await tarefaRepository.listarTarefasNaoConcluidas();
    } else {
      _tarefas = await tarefaRepository.listarTarefas();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descricaoController.text = '';
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text('Adicionar Tarefa'),
                  content: TextField(
                    controller: descricaoController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    TextButton(
                        onPressed: () async {
                          await tarefaRepository.adicionar(
                              Tarefa(descricaoController.text, false));
                          Navigator.pop(context);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "A tarefa ${descricaoController.text} foi criada.")));
                        },
                        child: const Text('Salvar')),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Não Concluídos', style: TextStyle(fontSize: 20)),
                  Switch(
                      value: apenasNaoConcluidos,
                      onChanged: (bool value) {
                        apenasNaoConcluidos = value;
                        obterTarefas();
                      }),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var tarefa = _tarefas[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        await tarefaRepository.remove(tarefa.getId());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "A tarefa ${tarefa.getDescricao()} foi deletada.")));
                        obterTarefas();
                      },
                      key: Key(tarefa.getId()),
                      child: ListTile(
                        title: Text(tarefa.getDescricao()),
                        trailing: Switch(
                            value: tarefa.getConcluido(),
                            onChanged: (bool value) async {
                              await tarefaRepository.alterar(
                                  tarefa.getId(), value);
                              obterTarefas();
                            }),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
