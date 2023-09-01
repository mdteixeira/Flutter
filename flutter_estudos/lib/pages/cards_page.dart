import 'package:flutter/material.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Torta de Camarão",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.blueAccent),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.network(
                          'https://i.ytimg.com/vi/1byHBcHVTek/maxresdefault.jpg',
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {}, child: const Text('Fazer Receita')),
                      TextButton(onPressed: () {}, child: const Text('Favorito'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
