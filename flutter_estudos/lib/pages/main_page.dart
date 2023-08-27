import 'package:flutter/material.dart';
import 'package:flutter_estudos/pages/dados_cadastrais.dart';
import 'package:flutter_estudos/pages/pagina1.dart';
import 'package:flutter_estudos/pages/pagina2.dart';
import 'package:flutter_estudos/pages/pagina3.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: const Text("Main page")),
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Text('Dados Cadastrais')),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DadosCadastrais(
                                  )));
                    },
                  ),
                  const Divider(),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Text('Termos de uso e privacidade')),
                    onTap: () {},
                  ),
                  const Divider(),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Text('Configurações')),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        posicaoPagina = value;
                      });
                    },
                    children: const [
                      Pagina1(),
                      Pagina2(),
                      Pagina3(),
                    ]),
              ),
              BottomNavigationBar(
                  onTap: (value) {
                    controller.jumpToPage(value);
                  },
                  currentIndex: posicaoPagina,
                  items: const [
                    BottomNavigationBarItem(
                        label: 'Início', icon: Icon(Icons.home)),
                    BottomNavigationBarItem(
                        label: 'Pesquisar', icon: Icon(Icons.search)),
                    BottomNavigationBarItem(
                        label: 'Ajustes', icon: Icon(Icons.settings)),
                  ])
            ],
          )),
    );
  }
}
