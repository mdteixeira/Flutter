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
              elevation: 4,
              child: Column(
                children: [
                  const Text("Torta de Camarão"),
                  Image.network(
                    'https://assets.unileversolutions.com/recipes-v2/35828.jpg',
                    width: 200,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
