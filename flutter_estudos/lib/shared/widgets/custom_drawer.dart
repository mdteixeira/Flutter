import 'package:flutter/material.dart';
import 'package:flutter_estudos/pages/dados_cadastrais.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/4792/4792929.png'),
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
            onTap: () {},
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
