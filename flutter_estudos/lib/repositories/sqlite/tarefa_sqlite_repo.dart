import 'package:flutter_estudos/model/tarefa_model_sqlite.dart';
import 'package:flutter_estudos/repositories/sqlite/sqlite_database.dart';

class TarefaSQLiteRepository {
  Future<List<TarefaSQLiteModel>> obterDados() async {
    List<TarefaSQLiteModel> tarefas = [];
    var db = await SQLiteDataBase().getDataBase();
    var result =
        await db.rawQuery('SELECT id, descricao, conlcuido FROM tarefas');

    for (var element in result) {
      tarefas.add(TarefaSQLiteModel(int.parse(element['id'].toString()),
          element['descricao'].toString(), element['concluido'] == '1'));
    }

    return tarefas;
  }

  Future<void> salvar(TarefaSQLiteModel tarefa) async {
    var db = await SQLiteDataBase().getDataBase();

    await db.rawInsert('INSERT INTO tarefas (descricao, concluido) values(?, ?)',
        [tarefa.descricao, tarefa.concluido]);
        
  }
}
