import 'package:flutter_estudos/model/tarefasB4A/tarefas_b4a_model.dart';
import 'package:flutter_estudos/repositories/back4app/b4a_custom_dio.dart';

class TarefaBack4AppRepository {
  final _customdio = Back4AppCustomDio();

  TarefaBack4AppRepository();

  Future<TarefasBack4AppModel> obterTarefas(bool apenasNaoConcluidas) async {
    var url = '/Tarefas';

    if (apenasNaoConcluidas) {
      url = '$url?where={"concluido":false}';
      var result = await _customdio.dio.get(url);
      return TarefasBack4AppModel.fromJson(result.data);
    }
    var result = await _customdio.dio.get(url);

    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criar(Tarefa tarefasBack4AppModel) async {
    try {
      await _customdio.dio
          .post('/Tarefas', data: tarefasBack4AppModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(Tarefa tarefasBack4AppModel) async {
    try {
      await _customdio.dio.put('/Tarefas/${tarefasBack4AppModel.objectId}',
          data: tarefasBack4AppModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectID) async {
    try {
      await _customdio.dio.delete('/Tarefas/$objectID');
    } catch (e) {
      rethrow;
    }
  }
}
