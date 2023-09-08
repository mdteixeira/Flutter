import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesSpPage extends StatefulWidget {
  const ConfiguracoesSpPage({super.key});

  @override
  State<ConfiguracoesSpPage> createState() => _ConfiguracoesSpPageState();
}

class _ConfiguracoesSpPageState extends State<ConfiguracoesSpPage> {
  late SharedPreferences storage;

  bool receberPushNotification = false;
  bool temaEscuro = false;

  final CHAVE_USERNAME = 'username';
  final CHAVE_ALTURA = 'altura';
  final CHAVE_PUSH_NOTIFICATIONS = 'notificacoes';
  final CHAVE_TEMA_ESCURO = 'tema_escuro';

  TextEditingController usernameController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    CarregarDados();
    super.initState();
  }

  CarregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      usernameController.text = storage.getString(CHAVE_USERNAME) ?? '';
      alturaController.text = (storage.getDouble(CHAVE_ALTURA) ?? 0).toString();
      receberPushNotification =
          storage.getBool(CHAVE_PUSH_NOTIFICATIONS) ?? false;
      temaEscuro = storage.getBool(CHAVE_TEMA_ESCURO) ?? false;
    });
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
                  receberPushNotification = value;
                });
              },
              value: receberPushNotification),
          SwitchListTile(
              title: const Text('Tema Escuro'),
              onChanged: (bool value) {
                setState(() {
                  temaEscuro = value;
                });
              },
              value: temaEscuro),
          TextButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                try {
                  await storage.setDouble(
                      CHAVE_ALTURA, double.parse(alturaController.text));
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
                await storage.setString(
                    CHAVE_USERNAME, usernameController.text);
                await storage.setBool(
                    CHAVE_PUSH_NOTIFICATIONS, receberPushNotification);
                await storage.setBool(CHAVE_TEMA_ESCURO, temaEscuro);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Os seus dados foram salvos.')));
                Navigator.pop(context);
              },
              child: const Text('Salvar')),
        ],
      ),
    ));
  }
}
