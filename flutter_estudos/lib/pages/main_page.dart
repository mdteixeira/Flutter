import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_estudos/pages/brasil_fields.dart';
import 'package:flutter_estudos/pages/cards_page.dart';
import 'package:flutter_estudos/pages/list_view_h.dart';
import 'package:flutter_estudos/pages/list_view_v.dart';
import 'package:flutter_estudos/pages/tarefa_page_sql.dart';
import 'package:flutter_estudos/pages/consultaCEP.dart';
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
          appBar: AppBar(title: const Text("APP_TITLE").tr()),
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
                      ConsultaCEP(),
                      ListViewVertical(),
                      ListViewHorizontal(),
                      TarefaPageSQL(),
                      BrasilFields()
                    ]),
              ),
              BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    controller.jumpToPage(value);
                  },
                  currentIndex: posicaoPagina,
                  items: const [
                    BottomNavigationBarItem(
                        label: 'Início', icon: Icon(Icons.home)),
                    BottomNavigationBarItem(
                        label: 'HTTP', icon: Icon(Icons.http)),
                    BottomNavigationBarItem(
                        label: 'Vertical', icon: Icon(Icons.view_list)),
                    BottomNavigationBarItem(
                        label: 'Horizontal', icon: Icon(Icons.view_column)),
                    BottomNavigationBarItem(
                        label: 'Tarefas', icon: Icon(Icons.check)),
                    BottomNavigationBarItem(
                        label: 'Brasil_fields', icon: Icon(Icons.flag)),
                  ])
            ],
          )),
    );
  }
}
