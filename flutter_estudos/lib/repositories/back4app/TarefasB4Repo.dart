import 'package:dio/dio.dart';
import 'package:flutter_estudos/model/tarefasB4A/tarefas_b4a_model.dart';

class TarefaBack4AppRepository {
  final _dio = Dio();

  TarefaBack4AppRepository() {
    _dio.options.headers['X-Parse-Application-Id'] =
        "WIq6fRmEcUz0fQFpo4YeKXhqhNx4gzeUWhSnCERX";
    _dio.options.headers['X-Parse-REST-API-Key'] =
        "TaoTI6Mow02Ub0rMmMCg6MhiIBBFcB9gB2BkJ1uK";
    _dio.options.headers['Content-Type'] = "application/json";
    _dio.options.baseUrl = 'https://parseapi.back4app.com/classes';
  }

  Future<TarefasBack4AppModel> obterTarefas(bool apenasNaoConcluidas) async {
    var url = '/Tarefas';

    if (apenasNaoConcluidas) {
      url = '$url?where={"concluido":false}';
      var result = await _dio.get(url);
      return TarefasBack4AppModel.fromJson(result.data);
    }
    var result = await _dio.get(url);

    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criar(Tarefa tarefasBack4AppModel) async {
    try {
      var response =
          await _dio.post('/Tarefas', data: tarefasBack4AppModel.toCreateJson());
    } catch (e) {
      throw e;
    }
  }
}
