import 'dart:convert';

import 'package:flutter_estudos/model/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentsRepositoryHttp {
  Future<List<CommentsModel>> retornaComentarios(int postId) async {
    var response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments'));
    if (response.statusCode == 200) {
      var jsonComments = jsonDecode(response.body);
      return (jsonComments as List)
          .map((e) => CommentsModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
