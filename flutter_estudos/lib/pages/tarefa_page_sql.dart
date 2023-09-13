import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/tarefa_model_sqlite.dart';
import 'package:flutter_estudos/repositories/sqlite/tarefa_sqlite_repo.dart';
import 'package:flutter_estudos/repositories/tarefa_repository.dart';
class TarefaPageSQL extends StatefulWidget {
  const TarefaPageSQL({super.key});

  @override
  State<TarefaPageSQL> createState() => _TarefaPageSQLState();
}

class _TarefaPageSQLState extends State<TarefaPageSQL> {
  TarefaSQLiteRepository tarefaRepository = TarefaSQLiteRepository();
  var _tarefas = const <TarefaSQLiteModel>[];
  var descricaoController = TextEditingController();

  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _tarefas = await tarefaRepository.obterDados(apenasNaoConcluidos);
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
                          await tarefaRepository.salvar(TarefaSQLiteModel(
                              0, descricaoController.text, false));
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
            Expanded(
              child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var tarefa = _tarefas[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        await tarefaRepository.remover(tarefa.id);
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
                              await tarefaRepository.atualizar(tarefa);
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
