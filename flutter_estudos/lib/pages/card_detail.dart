import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/card_detail.dart';

class CardDetailPage extends StatelessWidget {
  const CardDetailPage({super.key, required this.cardDetail});

  final CardDetail cardDetail;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cardDetail.title,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(
                    cardDetail.url,
                    width: double.infinity,
                  ),
                  Text(cardDetail.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
