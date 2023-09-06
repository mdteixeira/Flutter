import 'package:flutter/material.dart';
import 'package:flutter_estudos/repositories/linguagens_repository.dart';
import 'package:flutter_estudos/repositories/nivel_repository.dart';
import 'package:flutter_estudos/shared/widgets/text_label.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({
    super.key,
  });

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  DateTime? dataNascimento;

  var nivelRepository = NivelRepository();
  var niveis = [];
  var nivelSelecionado = "";

  var linguagensRepository = LinguagensRepository();
  var linguagens = [];
  List<String> linguagensSelecionadas = [];

  double salarioSelecionado = 0;

  bool salvando = false;

  late SharedPreferences storage;

  final CHAVE_NOME = 'nome';
  final CHAVE_DATA_NASCIMENTO = 'data_nascimento';
  final CHAVE_TEMPO_EXPERIENCIA = 'tempo_xp';
  final CHAVE_LINGUAGENS = 'linguagens_favoritas';
  final CHAVE_NIVEL_EXPERIENCIA = 'nivel_xp';
  final CHAVE_PRETENCAO_SALARIAL = 'pretencao_salarial';

  int tempoExperiencia = 0;
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
    storage = await SharedPreferences.getInstance();
    nomeController.text = storage.getString(CHAVE_NOME) ?? '';
    dataNascimentoController.text =
        storage.getString(CHAVE_DATA_NASCIMENTO) ?? '';
    nivelSelecionado = storage.getString(CHAVE_NIVEL_EXPERIENCIA) ?? '';
    linguagensSelecionadas = storage.getStringList(CHAVE_LINGUAGENS) ?? [];
    tempoExperiencia = storage.getInt(CHAVE_TEMPO_EXPERIENCIA) ?? 0;
    salarioSelecionado = storage.getDouble(CHAVE_PRETENCAO_SALARIAL) ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Dados"),
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
                        dataNascimento = data;
                      }
                    },
                  ),
                  const TextLabel(texto: 'Nível de experiência'),
                  Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              selected: nivelSelecionado == nivel,
                              title: Text(nivel.toString()),
                              value: nivel.toString(),
                              groupValue: nivelSelecionado,
                              onChanged: (value) {
                                setState(() {
                                  nivelSelecionado = value.toString();
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
                              value: linguagensSelecionadas.contains(linguagem),
                              onChanged: (bool? value) {
                                if (value!) {
                                  setState(() {
                                    linguagensSelecionadas.add(linguagem);
                                  });
                                } else {
                                  setState(() {
                                    linguagensSelecionadas.remove(linguagem);
                                  });
                                }
                              }),
                        )
                        .toList(),
                  ),
                  const TextLabel(texto: 'Tempo de experiência'),
                  DropdownButton(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: returnItems(10),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = int.parse(value.toString());
                        });
                      }),
                  TextLabel(
                      texto:
                          "Pretenção salarial: R\$ ${salarioSelecionado.round().toString()}"),
                  Slider(
                      min: 0,
                      max: 10000,
                      value: salarioSelecionado,
                      onChanged: (double value) {
                        setState(() {
                          salarioSelecionado = value;
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
                        if (dataNascimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Data de nascimento inválida.')));
                          return;
                        }
                        if (nivelSelecionado.trim() == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Nenhum nível foi selecionado.')));
                          return;
                        }
                        if (linguagensSelecionadas.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Você deve selecionar alguma linguagem.')));
                          return;
                        }
                        if (tempoExperiencia < 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Deve ter ao menos 1 ano de experiência.')));
                          return;
                        }
                        if (salarioSelecionado == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'A pretenção salarial deve ser maior que 0.')));
                          return;
                        }

                        await storage.setString(
                            CHAVE_NOME, nomeController.text);
                        await storage.setStringList(
                            CHAVE_LINGUAGENS, linguagensSelecionadas);
                        await storage.setString(
                            CHAVE_NIVEL_EXPERIENCIA, nivelSelecionado);
                        await storage.setString(CHAVE_TEMPO_EXPERIENCIA,
                            tempoExperiencia.toString());
                        await storage.setString(CHAVE_DATA_NASCIMENTO,
                            dataNascimentoController.text);
                        await storage.setInt(
                            CHAVE_TEMPO_EXPERIENCIA, tempoExperiencia);
                        await storage.setDouble(
                            CHAVE_PRETENCAO_SALARIAL, salarioSelecionado);

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
