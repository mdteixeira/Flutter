import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/tarefasB4A/tarefas_b4a_model.dart';
import 'package:flutter_estudos/repositories/back4app/TarefasB4Repo.dart';

class TarefaPageHttp extends StatefulWidget {
  const TarefaPageHttp({super.key});

  @override
  State<TarefaPageHttp> createState() => _TarefaPageHttpState();
}

class _TarefaPageHttpState extends State<TarefaPageHttp> {
  TarefaBack4AppRepository tarefaRepository = TarefaBack4AppRepository();
  var _tarefasBack4App = TarefasBack4AppModel([]);
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;
  var loading = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      loading = true;
    });
    _tarefasBack4App = await tarefaRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas com Back4App"),
      ),
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
                          await tarefaRepository.criar(TarefasBack4AppModel(descricaoController.text, false));
                          obterTarefas();
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
            loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                        itemCount: _tarefasBack4App.tarefas.length,
                        itemBuilder: (BuildContext bc, int index) {
                          var tarefa = _tarefasBack4App.tarefas[index];
                          return Dismissible(
                            onDismissed:
                                (DismissDirection dismissDirection) async {
                              // await tarefaRepository.remover(tarefa.id);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "A tarefa ${tarefa.descricao} foi deletada.")));
                              obterTarefas();
                            },
                            key: Key(tarefa.descricao),
                            child: ListTile(
                              title: Text(tarefa.descricao),
                              trailing: Switch(
                                  value: tarefa.concluido,
                                  onChanged: (bool value) async {
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
