import 'package:flutter_estudos/model/configs_model.dart';
import 'package:hive/hive.dart';

class ConfiguracoesRepository {
  static late Box _box;

  ConfiguracoesRepository._criar();

  static Future<ConfiguracoesRepository> carregar() async {
    if (Hive.isBoxOpen('configuracoes')) {
      _box = Hive.box('configuracoes');
    } else {
      _box = await Hive.openBox('configuracoes');
    }
    return ConfiguracoesRepository._criar();
  }

  void salvar(ConfiguracoesModel configuracoesModel) {
    _box.put('configuracoesModel', {
      'userName': configuracoesModel.userName,
      'altura': configuracoesModel.altura,
      'receberNotificacoes': configuracoesModel.receberNotificacoes,
      'temaEscuro': configuracoesModel.temaEscuro,
    });
  }

  ConfiguracoesModel obterDados() {
    var configuracoes = _box.get('configuracoesModel');
    if (configuracoes == null) {
      return ConfiguracoesModel.vazio();
    }
    return ConfiguracoesModel(
        configuracoes['userName'], configuracoes['altura'], configuracoes['receberNotificacoes'], configuracoes['temaEscuro']);
  }
}
