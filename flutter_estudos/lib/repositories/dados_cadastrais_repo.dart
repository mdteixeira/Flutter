import 'package:flutter_estudos/model/dados_cadastrais_model.dart';
import 'package:hive/hive.dart';

class DadosCadastraisRepository {
  static late Box _box;

  DadosCadastraisRepository._criar();

  static Future<DadosCadastraisRepository> carregar() async {
    if (Hive.isBoxOpen('DadosCadastraisModel')) {
      _box = Hive.box('DadosCadastraisModel');
    } else {
      _box = await Hive.openBox('DadosCadastraisModel');
    }
    return DadosCadastraisRepository._criar();
  }

  salvar(DadosCadastraisModel dadosCadastraisModel) {
    _box.put('dadosCadastraisModel', dadosCadastraisModel);
  }

  DadosCadastraisModel obterDados() {
    var dadosCadastraisModel = _box.get('dadosCadastrais');
    if (dadosCadastraisModel == null) {
      return DadosCadastraisModel.vazio();
    }
    return dadosCadastraisModel;
  }
}
