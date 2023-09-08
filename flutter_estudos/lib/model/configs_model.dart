class ConfiguracoesModel {
  String _userName = '';
  double _altura = 0;
  bool _receberNotificacoes = false;
  bool _temaEscuro = false;

  ConfiguracoesModel.vazio() {
    _userName = '';
    _altura = 0;
    _receberNotificacoes = false;
    _temaEscuro = false;
  }

  ConfiguracoesModel(this._userName, this._altura, this._receberNotificacoes,
      this._temaEscuro);

    String get userName => _userName;
    
    set userName(String username) => _userName = username;
    
    double get altura => _altura;
    
    set altura(double altura) => _altura = altura;
    
    bool get receberNotificacoes => _receberNotificacoes;
    
    set receberNotificacoes(bool receberNotificacoes) => _receberNotificacoes = receberNotificacoes;
    
    bool get temaEscuro => _temaEscuro;
    
    set temaEscuro(bool temaEscuro) => _temaEscuro = temaEscuro;
}
