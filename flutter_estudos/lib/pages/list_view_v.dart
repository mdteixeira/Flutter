import 'package:flutter/material.dart';
import 'package:flutter_estudos/shared/app_images.dart';

class ListViewVertical extends StatefulWidget {
  const ListViewVertical({super.key});

  @override
  State<ListViewVertical> createState() => _Pagina1State();
}

class _Pagina1State extends State<ListViewVertical> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {},
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem(value: 'opcao1', child: Text("Opção 1")),
                PopupMenuItem(value: 'opcao2', child: Text("Opção 2")),
                PopupMenuItem(value: 'opcao3', child: Text("Opção 3")),
              ];
            },
          ),
          leading: Image.asset(AppImages.user1),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User 1',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('08:00')
            ],
          ),
          subtitle: const Text('Olá, boa tarde!'),
        )
      ],
    );
  }
}
