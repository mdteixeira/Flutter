import 'package:flutter_estudos/model/card_detail.dart';

class CardDetailRepository {
  Future<CardDetail> get() async {
    return CardDetail(
        'Torta de frango',
        'https://www.receitasnestle.com.br/sites/default/files/styles/recipe_detail_desktop/public/srh_recipes/6891f26fa564184d4747aa6e56455c2e.jpg?itok=-Hnwi4ZK',
        'Torta simples e rápida, confira agora!');
  }
}
