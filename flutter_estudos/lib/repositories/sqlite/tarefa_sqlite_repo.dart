import 'package:flutter_estudos/model/tarefa_model_sqlite.dart';
import 'package:flutter_estudos/repositories/sqlite/sqlite_database.dart';

class TarefaSQLiteRepository {
  Future<List<TarefaSQLiteModel>> obterDados(bool apenasNaoConcluidos) async {
    List<TarefaSQLiteModel> tarefas = [];
    var db = await SQLiteDataBase().getDataBase();
    
    var result = await db.rawQuery(apenasNaoConcluidos
        ? 'SELECT id, descricao, concluido FROM tarefas WHERE concluido = 0'
        : 'SELECT id, descricao, concluido FROM tarefas');

    for (var element in result) {
      tarefas.add(TarefaSQLiteModel(int.parse(element['id'].toString()),
          element['descricao'].toString(), element['concluido'] == 1));
    }

    return tarefas;
  }

  Future<void> salvar(TarefaSQLiteModel tarefa) async {
    var db = await SQLiteDataBase().getDataBase();

    await db.rawInsert(
        'INSERT INTO tarefas (descricao, concluido) values(?, ?)',
        [tarefa.descricao, tarefa.concluido]);
  }

  Future<void> atualizar(TarefaSQLiteModel tarefa) async {
    var db = await SQLiteDataBase().getDataBase();

    await db.rawInsert(
        'UPDATE tarefas SET descricao = ? , concluido = ? WHERE id = ?',
        [tarefa.descricao, tarefa.concluido, tarefa.id]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().getDataBase();

    await db.rawInsert('DELETE FROM tarefas WHERE id = ?', [id]);
  }
}
