import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/configs_model.dart';
import 'package:flutter_estudos/repositories/configs_repo.dart';
import 'package:hive/hive.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();

  TextEditingController usernameController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    CarregarDados();
    super.initState();
  }

  CarregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();

    usernameController.text = configuracoesModel.userName;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Username'),
              controller: usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Altura'),
              controller: alturaController,
            ),
          ),
          SwitchListTile(
              title: const Text('Receber notificações por Push'),
              onChanged: (bool value) {
                setState(() {
                  configuracoesModel.receberNotificacoes = value;
                });
              },
              value: configuracoesModel.receberNotificacoes),
          SwitchListTile(
              title: const Text('Tema Escuro'),
              onChanged: (bool value) {
                setState(() {
                  configuracoesModel.temaEscuro = value;
                });
              },
              value: configuracoesModel.temaEscuro),
          TextButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                try {
                  configuracoesModel.altura =
                      double.parse(alturaController.text);
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                            title: const Text('Meu app'),
                            content: const Text("Informar uma altura válida."),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ok'))
                            ]);
                      });
                }

                configuracoesModel.userName = usernameController.text;
                configuracoesRepository.salvar(configuracoesModel);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Os seus dados foram salvos.')));
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context);
              },
              child: const Text('Salvar')),
        ],
      ),
    ));
  }
}
