import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/dados_cadastrais_model.dart';
import 'package:flutter_estudos/repositories/dados_cadastrais_repo.dart';
import 'package:flutter_estudos/repositories/linguagens_repository.dart';
import 'package:flutter_estudos/repositories/nivel_repository.dart';
import 'package:flutter_estudos/shared/widgets/text_label.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({
    super.key,
  });

  @override
  State<DadosCadastraisHivePage> createState() =>
      _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");

  var nivelRepository = NivelRepository();
  var niveis = [];

  var linguagensRepository = LinguagensRepository();
  var linguagens = [];

  bool salvando = false;

  List<DropdownMenuItem<int>> returnItems(int maxQnt) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i < maxQnt; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text('$i'),
      ));
    }
    return itens;
  }

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    CarregarDados();
  }

  CarregarDados() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.carregar();
    dadosCadastraisModel = dadosCadastraisRepository.obterDados();
    nomeController.text = dadosCadastraisModel.nome ?? '';
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null
        ? ''
        : dadosCadastraisModel.dataNascimento.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Dados Hive"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const TextLabel(texto: 'Nome'),
                  TextField(
                    controller: nomeController,
                  ),
                  const TextLabel(texto: 'Data de nascimento'),
                  TextField(
                    controller: dataNascimentoController,
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1900, 5, 20),
                          lastDate: DateTime(2024, 1, 1));
                      if (data != null) {
                        dataNascimentoController.text = data.toString();
                        dadosCadastraisModel.dataNascimento = data;
                      }
                    },
                  ),
                  const TextLabel(texto: 'Nível de experiência'),
                  Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              selected: dadosCadastraisModel.nivelExperiencia ==
                                  nivel,
                              title: Text(nivel.toString()),
                              value: nivel.toString(),
                              groupValue: dadosCadastraisModel.nivelExperiencia,
                              onChanged: (value) {
                                setState(() {
                                  dadosCadastraisModel.nivelExperiencia =
                                      value.toString();
                                });
                              }))
                          .toList()),
                  const TextLabel(texto: 'Linguagens preferidas'),
                  Column(
                    children: linguagens
                        .map(
                          (linguagem) => CheckboxListTile(
                              dense: true,
                              title: Text(linguagem),
                              value: dadosCadastraisModel.linguagens
                                  .contains(linguagem),
                              onChanged: (bool? value) {
                                if (value!) {
                                  setState(() {
                                    dadosCadastraisModel.linguagens
                                        .add(linguagem);
                                  });
                                } else {
                                  setState(() {
                                    dadosCadastraisModel.linguagens
                                        .remove(linguagem);
                                  });
                                }
                              }),
                        )
                        .toList(),
                  ),
                  const TextLabel(texto: 'Tempo de experiência'),
                  DropdownButton(
                      value: dadosCadastraisModel.tempoExperiencia,
                      isExpanded: true,
                      items: returnItems(10),
                      onChanged: (value) {
                        setState(() {
                          dadosCadastraisModel.tempoExperiencia =
                              int.parse(value.toString());
                        });
                      }),
                  TextLabel(
                      texto:
                          "Pretenção salarial: R\$ ${dadosCadastraisModel.pretensaoSalarial?.round().toString()}"),
                  Slider(
                      min: 0,
                      max: 10000,
                      value: dadosCadastraisModel.pretensaoSalarial ?? 0,
                      onChanged: (double value) {
                        setState(() {
                          dadosCadastraisModel.pretensaoSalarial = value;
                        });
                      }),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          salvando = false;
                        });
                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('O nome deve ser preenchido.')));
                          return;
                        }
                        if (dadosCadastraisModel.dataNascimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Data de nascimento inválida.')));
                          return;
                        }
                        if (dadosCadastraisModel.nivelExperiencia!.trim() ==
                                '' ||
                            dadosCadastraisModel.nivelExperiencia == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Nenhum nível foi selecionado.')));
                          return;
                        }
                        if (dadosCadastraisModel.linguagens.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Você deve selecionar alguma linguagem.')));
                          return;
                        }
                        if (dadosCadastraisModel.tempoExperiencia == 0 ||
                            dadosCadastraisModel.tempoExperiencia == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Deve ter ao menos 1 ano de experiência.')));
                          return;
                        }
                        if (dadosCadastraisModel.pretensaoSalarial == 0 ||
                            dadosCadastraisModel.pretensaoSalarial == null) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'A pretenção salarial deve ser maior que 0.')));
                          return;
                        }
                        dadosCadastraisModel.nome = nomeController.text;
                        dadosCadastraisRepository.salvar(dadosCadastraisModel);

                        setState(() {
                          salvando = true;
                        });
                        Future.delayed(const Duration(milliseconds: 10), () {
                          setState(() {
                            salvando = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Os seus dados foram salvos.')));
                          });
                          Navigator.pop(context);
                        });
                      },
                      child: const Text('Salvar')),
                ],
              ),
      ),
    );
  }
}
