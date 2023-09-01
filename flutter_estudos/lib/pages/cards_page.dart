import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/card_detail.dart';
import 'package:flutter_estudos/pages/card_detail.dart';
import 'package:flutter_estudos/repositories/card_detail_repository.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  CardDetail? cardDetail;
  var cardDetailRepository = CardDetailRepository();
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    cardDetail = await cardDetailRepository.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: cardDetail == null
                ? const LinearProgressIndicator()
                : Card(
                    elevation: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                cardDetail!.title,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blueAccent),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.network(
                                cardDetail!.url,
                                width: double.infinity,
                              ),
                              Text(cardDetail!.text),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CardDetailPage(
                                                cardDetail: cardDetail!,
                                              )));
                                },
                                child: const Text('Fazer Receita')),
                            TextButton(
                                onPressed: () {}, child: const Text('Favorito'))
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
