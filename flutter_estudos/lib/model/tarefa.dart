import 'package:flutter/material.dart';

class Tarefa {
  final String _id = UniqueKey().toString();
  String _descricao = "";
  bool _concluido = false;

  Tarefa(this._descricao, this._concluido);

  String get id => _id;
  bool get concluido => _concluido;
  String get descricao => _descricao;

  set descricao(String descricao) {
    _descricao = descricao;
  }
  
  set concluido(bool concluido) {
    _concluido = concluido;
  }
}
