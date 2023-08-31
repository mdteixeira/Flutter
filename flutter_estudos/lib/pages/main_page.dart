import 'package:flutter/material.dart';
import 'package:flutter_estudos/pages/cards_page.dart';
import 'package:flutter_estudos/pages/pagina2.dart';
import 'package:flutter_estudos/pages/pagina3.dart';
import 'package:flutter_estudos/shared/widgets/custom_drawer.dart';

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
          drawer: const CustomDrawer(),
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
                      CardsPage(),
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
