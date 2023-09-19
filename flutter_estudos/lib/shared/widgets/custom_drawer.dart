import 'package:flutter/material.dart';
import 'package:flutter_estudos/pages/Characters/characters_page.dart';
import 'package:flutter_estudos/pages/configuracoes/configuracoes_hive_page.dart';
import 'package:flutter_estudos/pages/dados_cadastrais/dados_cadastrais.dart';
import 'package:flutter_estudos/pages/login_page.dart';
import 'package:flutter_estudos/pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';
import 'package:flutter_estudos/pages/posts_page.dart';
import 'package:flutter_estudos/pages/tarefa_http_page.dart';
import 'package:flutter_estudos/repositories/back4app/TarefasB4Repo.dart';
import 'package:intl/intl.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return const Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.photo_camera),
                              title: Text('Câmera'),
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('Galeria'),
                            )
                          ],
                        );
                      });
                },
                child: CircleAvatar(
                  child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/4792/4792929.png'),
                ),
              ),
              accountName: const Text('Matheus Teixeira'),
              accountEmail: const Text("email@email.com")),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Dados Cadastrais',
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DadosCadastrais()));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Termos de uso e privacidade',
                    ),
                  ],
                )),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                        padding: const EdgeInsets.all(30),
                        child: const Column(children: [
                          Text(
                            'Termos e Condições',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse purus tellus, dignissim nec semper vitae, luctus non ipsum. Cras vel suscipit nunc, vitae consectetur sem. Vivamus sit amet massa a augue rhoncus sodales non et elit. Proin malesuada odio turpis, lobortis ultricies diam convallis vel. Integer eget velit sed tellus hendrerit tempor. Aliquam non semper lorem, eget gravida lectus. Aenean auctor mauris tellus, sit amet porttitor nulla egestas nec. Pellentesque eget tellus elit. Phasellus posuere scelerisque nisl consequat consequat.',
                            textAlign: TextAlign.justify,
                          ),
                        ]));
                  });
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.numbers),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gerador de números',
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) =>
                          const NumerosAleatoriosHivePage()));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Configurações',
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) =>
                          const ConfiguracoesHivePage()));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.list),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Posts',
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) => const PostsPage()));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.person_4),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Heróis',
                    ),
                  ],
                )),
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) => const CharactersPage()));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Tarefas HTTP',
                    ),
                  ],
                )),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) => const TarefaPageHttp()));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.language),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Intl',
                    ),
                  ],
                )),
            onTap: () {
              var f = NumberFormat('#,###.0#', 'en_US');
              var fBR = NumberFormat('#,###.0#', 'pt_BR');
              print(f.format(12345.345));
              print(fBR.format(12345.345));

              var dia = DateTime.now();
              print(DateFormat('EEEEE', 'en_US').format(dia));
            },
          ),
          Expanded(child: Container()),
          Center(
              child: TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext bc) {
                          return AlertDialog(
                            icon: const Icon(Icons.logout),
                            actionsAlignment: MainAxisAlignment.center,
                            title: const Text(
                              'Você deseja sair?',
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  child: const Text('Sair')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'))
                            ],
                          );
                        });
                  },
                  child: const Text('Sair')))
        ],
      ),
    );
  }
}
